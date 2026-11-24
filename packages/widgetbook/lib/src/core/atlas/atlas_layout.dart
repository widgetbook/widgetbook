import 'package:flutter/foundation.dart';
import 'package:path/path.dart' show posix;

import '../framework/framework.dart';
import '../navigation/tree.dart';

/// The columns, from `first` to `last` inclusive, that an [AtlasGroup] spans,
/// its position in a stack of groups sharing these columns, and the number of
/// rows it needs.
@internal
typedef AtlasGroupSpan = ({
  AtlasGroup group,
  int first,
  int last,
  int stackIndex,
  int rows,
});

/// Arranges the nodes of an [AtlasFlow] into columns, left to right.
///
/// Each node is placed by its longest path from an entry node, ignoring links
/// that close a cycle, so the last screens of a flow end up last. With
/// [AtlasFlow.groups], every group gets its own columns in declaration order,
/// keeping that order within the group. A group that no path of forward links
/// connects to the groups directly before it, e.g. one of several areas a hub
/// leads to, is stacked below them in their columns.
/// Links to the same or an earlier column are [backLinks].
@internal
class AtlasLayout {
  factory AtlasLayout(AtlasFlow flow) {
    final nodes = flow.pages;
    final (:ordered, :depths) = _layer(flow);

    final parent = flow.parent;
    if (parent != null && identical(parent.layoutFlow, flow)) {
      final variantDepths = [
        for (final variant in parent.variantFlows) _layer(variant).depths,
      ];
      for (final node in nodes) {
        depths[node] = variantDepths
            .map((depths) => depths[node] ?? 0)
            .reduce((a, b) => a > b ? a : b);
      }
    }

    final reachable = <AtlasNode, Set<AtlasNode>>{};
    for (final node in [...nodes]..sort((a, b) => depths[b]! - depths[a]!)) {
      reachable[node] = {
        for (final next in flow.leadsTo(node))
          if (depths[next]! > depths[node]!) ...{next, ...?reachable[next]},
      };
    }

    final members = <AtlasGroup?, List<AtlasNode>>{};
    for (final node in ordered) {
      members.putIfAbsent(flow.groupOf(node), () => []).add(node);
    }

    bool connected(AtlasGroup a, AtlasGroup b) {
      bool reaches(AtlasGroup from, AtlasGroup to) {
        final targets = members[to]!.toSet();
        return members[from]!.any(
          (node) => reachable[node]!.any(targets.contains),
        );
      }

      return reaches(a, b) || reaches(b, a);
    }

    final slots = <List<AtlasGroup?>>[];
    for (final group in flow.groups.where(members.containsKey)) {
      final slot = slots.lastOrNull;
      if (slot != null && slot.every((other) => !connected(group, other!))) {
        slot.add(group);
      } else {
        slots.add([group]);
      }
    }
    if (members.containsKey(null)) slots.add([null]);

    final columnOf = <AtlasNode, int>{};
    final rowOf = <AtlasNode, int>{};
    final groupSpans = <AtlasGroupSpan>[];
    var offset = 0;
    for (final slot in slots) {
      var width = 0;
      for (final (stackIndex, group) in slot.indexed) {
        final groupMembers = members[group]!;
        final levels =
            groupMembers.map((node) => depths[node]!).toSet().toList()..sort();
        final rows = List.filled(levels.length, 0);
        for (final node in groupMembers) {
          final level = levels.indexOf(depths[node]!);
          columnOf[node] = offset + level;
          rowOf[node] = rows[level]++;
        }
        if (group != null) {
          groupSpans.add((
            group: group,
            first: offset,
            last: offset + levels.length - 1,
            stackIndex: stackIndex,
            rows: rows.reduce((a, b) => a > b ? a : b),
          ));
        }
        if (levels.length > width) width = levels.length;
      }
      offset += width;
    }

    final columns = [for (var i = 0; i < offset; i++) <AtlasNode>[]];
    for (final node in ordered) {
      columns[columnOf[node]!].add(node);
    }

    final backLinks = {
      for (final from in nodes)
        for (final to in flow.leadsTo(from))
          if (columnOf[to]! <= columnOf[from]!) (from, to),
    };

    return AtlasLayout._(columns, columnOf, rowOf, backLinks, groupSpans);
  }

  AtlasLayout._(
    this.columns,
    this._columnOf,
    this._rowOf,
    this.backLinks,
    this.groupSpans,
  );

  final List<List<AtlasNode>> columns;
  final Map<AtlasNode, int> _columnOf;
  final Map<AtlasNode, int> _rowOf;
  final Set<(AtlasNode, AtlasNode)> backLinks;
  final List<AtlasGroupSpan> groupSpans;

  int columnOf(AtlasNode node) => _columnOf[node]!;

  /// The row of [node] within its group, or within the ungrouped nodes.
  int rowOf(AtlasNode node) => _rowOf[node]!;

  bool isBackLink(AtlasNode from, AtlasNode to) {
    return backLinks.contains((from, to));
  }

  /// Orders the nodes of [flow] from its entry nodes on and assigns each the
  /// length of its longest path from an entry node, ignoring links that close
  /// a cycle.
  static ({List<AtlasNode> ordered, Map<AtlasNode, int> depths}) _layer(
    AtlasFlow flow,
  ) {
    final nodes = flow.pages;
    final targets = {for (final node in nodes) ...flow.leadsTo(node)};
    final entryNodes = nodes.where((node) => !targets.contains(node));

    final onPath = <AtlasNode>{};
    final visited = <AtlasNode>{};
    final finished = <AtlasNode>[];
    final cycleLinks = <(AtlasNode, AtlasNode)>{};

    void visit(AtlasNode node) {
      if (!visited.add(node)) return;
      onPath.add(node);
      for (final next in flow.leadsTo(node)) {
        if (onPath.contains(next)) {
          cycleLinks.add((node, next));
        } else {
          visit(next);
        }
      }
      onPath.remove(node);
      finished.add(node);
    }

    entryNodes.forEach(visit);
    nodes.forEach(visit);

    final ordered = finished.reversed.toList();
    final depths = <AtlasNode, int>{};
    for (final node in ordered) {
      final depth = depths.putIfAbsent(node, () => 0);
      for (final next in flow.leadsTo(node)) {
        if (cycleLinks.contains((node, next))) continue;
        if ((depths[next] ?? -1) <= depth) depths[next] = depth + 1;
      }
    }

    return (ordered: ordered, depths: depths);
  }
}

@internal
Set<Story> registeredStories(Config config) {
  return {for (final component in config.components) ...component.stories};
}

/// Whether [node] is a page whose story is not part of [Config.components],
/// so it has neither a name nor a path to navigate to.
@internal
bool isUnregisteredPage(AtlasNode node, Set<Story> registered) {
  return node is AtlasPage && !registered.contains(node.story);
}

/// The navigation path of [flow], below its parent flow if it is a variant.
@internal
String atlasFlowPath(AtlasFlow flow) {
  final parent = flow.parent;
  return parent == null
      ? posix.join(atlasPath, flow.name)
      : posix.join(atlasPath, parent.name, flow.name);
}

/// The navigation path of a page with args, which is listed below its flow.
@internal
String atlasPagePath(AtlasFlow flow, AtlasPage page) {
  return posix.join(atlasFlowPath(flow), page.pathSegment);
}

/// The flows shown for [flow]: its variants, or the flow itself.
@internal
List<AtlasFlow> atlasVisibleFlows(AtlasFlow flow) {
  return flow.variants.isEmpty ? [flow] : flow.variantFlows;
}
