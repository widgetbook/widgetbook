import 'package:flutter/foundation.dart';

import '../framework/framework.dart';

/// Arranges the pages of an [AtlasFlow] into columns by their shortest
/// distance from an entry page, i.e. a page that no other page leads to.
/// Pages that are only reachable through a cycle start a column of their own.
@internal
class AtlasLayout {
  factory AtlasLayout(AtlasFlow flow) {
    final pages = flow.pages;
    final targets = {for (final targets in flow.links.values) ...targets};
    final entryPages = pages.where((page) => !targets.contains(page));
    final depths = <Story, int>{};

    void visit(Story start) {
      if (depths.containsKey(start)) return;
      depths[start] = 0;

      final queue = [start];
      while (queue.isNotEmpty) {
        final current = queue.removeAt(0);
        for (final next in flow.leadsTo(current)) {
          if (depths.containsKey(next)) continue;
          depths[next] = depths[current]! + 1;
          queue.add(next);
        }
      }
    }

    entryPages.forEach(visit);
    pages.forEach(visit);

    final columns = <List<Story>>[];
    depths.forEach((page, depth) {
      while (columns.length <= depth) {
        columns.add([]);
      }
      columns[depth].add(page);
    });

    return AtlasLayout._(columns);
  }

  AtlasLayout._(this.columns);

  final List<List<Story>> columns;

  int columnOf(Story page) {
    return columns.indexWhere((column) => column.contains(page));
  }
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
