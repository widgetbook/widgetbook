/// @docImport 'config.dart';
library;

import 'story.dart';

/// A named flow through the pages of an app, where each page is a [Story]
/// mapped to the stories it leads to.
///
/// Flows are declared outside of the stories they reference, so two stories
/// can lead to each other without a circular initialization. Every referenced
/// story must belong to a component in [Config.components].
class AtlasFlow {
  const AtlasFlow({
    required this.name,
    required this.links,
  });

  final String name;

  /// Maps each page to the pages it leads to.
  final Map<Story, List<Story>> links;

  /// All pages of this flow in declaration order, including pages that only
  /// appear as a target.
  List<Story> get pages {
    final pages = <Story>{};
    links.forEach((from, targets) {
      pages
        ..add(from)
        ..addAll(targets);
    });
    return pages.toList();
  }

  List<Story> leadsTo(Story story) => links[story] ?? const [];

  List<Story> reachedFrom(Story story) {
    return [
      for (final MapEntry(key: from, value: targets) in links.entries)
        if (targets.contains(story)) from,
    ];
  }
}
