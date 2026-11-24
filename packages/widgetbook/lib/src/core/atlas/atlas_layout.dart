import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../framework/framework.dart';
import '../navigation/tree.dart';

/// The columns, from `first` to `last` inclusive, that an [AtlasGroup] spans.
@internal
typedef AtlasGroupSpan = ({AtlasGroup group, int first, int last});

/// Arranges the nodes of an [AtlasFlow] into columns, left to right.
///
/// Each node is placed by its longest path from an entry node, ignoring links
/// that close a cycle, so the last screens of a flow end up last. With
/// [AtlasFlow.groups], every group gets its own columns in declaration order,
/// keeping that order within the group. Links to the same or an earlier
/// column are [backLinks].
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

    final columnOf = <AtlasNode, int>{};
    final groupSpans = <AtlasGroupSpan>[];
    var offset = 0;
    for (final group in [...flow.groups, null]) {
      final members = ordered.where((node) => flow.groupOf(node) == group);
      if (members.isEmpty) continue;

      final levels = members.map((node) => depths[node]!).toSet().toList()
        ..sort();
      for (final node in members) {
        columnOf[node] = offset + levels.indexOf(depths[node]!);
      }
      if (group != null) {
        groupSpans.add((
          group: group,
          first: offset,
          last: offset + levels.length - 1,
        ));
      }
      offset += levels.length;
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

    return AtlasLayout._(columns, columnOf, backLinks, groupSpans);
  }

  AtlasLayout._(this.columns, this._columnOf, this.backLinks, this.groupSpans);

  final List<List<AtlasNode>> columns;
  final Map<AtlasNode, int> _columnOf;
  final Set<(AtlasNode, AtlasNode)> backLinks;
  final List<AtlasGroupSpan> groupSpans;

  int columnOf(AtlasNode node) => _columnOf[node]!;

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
      ? p.join(atlasPath, flow.name)
      : p.join(atlasPath, parent.name, flow.name);
}

/// The navigation path of a page with args, which is listed below its flow.
@internal
String atlasPagePath(AtlasFlow flow, AtlasPage page) {
  return p.join(atlasFlowPath(flow), page.pathSegment);
}

/// The flows shown for [flow]: its variants, or the flow itself.
@internal
List<AtlasFlow> atlasVisibleFlows(AtlasFlow flow) {
  return flow.variants.isEmpty ? [flow] : flow.variantFlows;
}
