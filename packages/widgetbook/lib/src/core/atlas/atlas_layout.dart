import 'package:flutter/foundation.dart';

import '../framework/framework.dart';

/// Arranges the pages of an [AtlasFlow] into columns, left to right.
///
/// Links that close a cycle (e.g. going back or retrying) are [backLinks].
/// Every other link points to a later column, as each page is placed by its
/// longest path from an entry page, so the last screens of a flow end up last.
@internal
class AtlasLayout {
  factory AtlasLayout(AtlasFlow flow) {
    final pages = flow.pages;
    final targets = {for (final targets in flow.links.values) ...targets};
    final entryPages = pages.where((page) => !targets.contains(page));

    final onPath = <Story>{};
    final visited = <Story>{};
    final finished = <Story>[];
    final backLinks = <(Story, Story)>{};

    void visit(Story page) {
      if (!visited.add(page)) return;
      onPath.add(page);
      for (final next in flow.leadsTo(page)) {
        if (onPath.contains(next)) {
          backLinks.add((page, next));
        } else {
          visit(next);
        }
      }
      onPath.remove(page);
      finished.add(page);
    }

    entryPages.forEach(visit);
    pages.forEach(visit);

    final depths = <Story, int>{};
    for (final page in finished.reversed) {
      final depth = depths.putIfAbsent(page, () => 0);
      for (final next in flow.leadsTo(page)) {
        if (backLinks.contains((page, next))) continue;
        if ((depths[next] ?? -1) <= depth) depths[next] = depth + 1;
      }
    }

    final columns = <List<Story>>[];
    for (final page in finished.reversed) {
      final depth = depths[page]!;
      while (columns.length <= depth) {
        columns.add([]);
      }
      columns[depth].add(page);
    }

    return AtlasLayout._(columns, backLinks);
  }

  AtlasLayout._(this.columns, this.backLinks);

  final List<List<Story>> columns;
  final Set<(Story, Story)> backLinks;

  bool isBackLink(Story from, Story to) => backLinks.contains((from, to));
}

/// Throws if [config] has an [AtlasFlow] referencing a story that is not part
/// of [Config.components], as such a story has no path to navigate to.
@internal
void assertAtlasStoriesRegistered(Config config) {
  final registered = {
    for (final component in config.components) ...component.stories,
  };

  for (final flow in config.atlas) {
    if (flow.pages.any((page) => !registered.contains(page))) {
      throw FlutterError(
        'The "${flow.name}" AtlasFlow references a story '
        'that is not part of Config.components.',
      );
    }
  }
}
