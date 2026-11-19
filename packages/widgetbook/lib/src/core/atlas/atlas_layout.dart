import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../framework/framework.dart';
import '../navigation/tree.dart';

/// Arranges the nodes of an [AtlasFlow] into columns, left to right.
///
/// Links that close a cycle (e.g. going back or retrying) are [backLinks].
/// Every other link points to a later column, as each node is placed by its
/// longest path from an entry node, so the last screens of a flow end up last.
@internal
class AtlasLayout {
  factory AtlasLayout(AtlasFlow flow) {
    final nodes = flow.pages;
    final targets = {for (final node in nodes) ...flow.leadsTo(node)};
    final entryNodes = nodes.where((node) => !targets.contains(node));

    final onPath = <AtlasNode>{};
    final visited = <AtlasNode>{};
    final finished = <AtlasNode>[];
    final backLinks = <(AtlasNode, AtlasNode)>{};

    void visit(AtlasNode node) {
      if (!visited.add(node)) return;
      onPath.add(node);
      for (final next in flow.leadsTo(node)) {
        if (onPath.contains(next)) {
          backLinks.add((node, next));
        } else {
          visit(next);
        }
      }
      onPath.remove(node);
      finished.add(node);
    }

    entryNodes.forEach(visit);
    nodes.forEach(visit);

    final depths = <AtlasNode, int>{};
    for (final node in finished.reversed) {
      final depth = depths.putIfAbsent(node, () => 0);
      for (final next in flow.leadsTo(node)) {
        if (backLinks.contains((node, next))) continue;
        if ((depths[next] ?? -1) <= depth) depths[next] = depth + 1;
      }
    }

    final columns = <List<AtlasNode>>[];
    for (final node in finished.reversed) {
      final depth = depths[node]!;
      while (columns.length <= depth) {
        columns.add([]);
      }
      columns[depth].add(node);
    }

    return AtlasLayout._(columns, backLinks);
  }

  AtlasLayout._(this.columns, this.backLinks);

  final List<List<AtlasNode>> columns;
  final Set<(AtlasNode, AtlasNode)> backLinks;

  bool isBackLink(AtlasNode from, AtlasNode to) {
    return backLinks.contains((from, to));
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

/// The navigation path of a page with args, which is listed below its flow.
@internal
String atlasPagePath(AtlasFlow flow, AtlasPage page) {
  return p.join(atlasPath, flow.name, page.pathSegment);
}
