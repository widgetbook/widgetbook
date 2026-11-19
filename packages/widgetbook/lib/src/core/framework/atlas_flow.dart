/// @docImport 'config.dart';
library;

import 'package:flutter/widgets.dart';

import 'scenario.dart';
import 'story.dart';
import 'story_args.dart';

/// What a node of an [AtlasFlow] leads to: an [AtlasNode], or an [AtlasLink]
/// to describe the link.
abstract interface class AtlasTarget {}

/// A node of an [AtlasFlow]: a [Story], an [AtlasPage] or an [AtlasTerminal].
///
/// A bare [Story] is shorthand for `AtlasPage(story)`.
abstract interface class AtlasNode implements AtlasTarget {}

/// A link to [to], with a [label] shown on its arrow and a [description] shown
/// when hovering the label.
class AtlasLink implements AtlasTarget {
  const AtlasLink({
    required this.to,
    this.label,
    this.description,
  });

  final AtlasNode to;
  final String? label;
  final String? description;
}

/// Wraps the rendered [node] of an [AtlasFlow], e.g. to dim it or add a badge.
typedef AtlasNodeDecorator = Widget Function(
  BuildContext context,
  AtlasNode node,
  Widget child,
);

/// A [story] shown as a page of an [AtlasFlow], optionally in a specific state.
///
/// Pages with [args] are listed below their flow in the navigation tree and
/// render the story with those args. Two pages are the same node when they
/// share an [id], or, without ids, the same [story] and [args] instance.
class AtlasPage<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    implements AtlasNode {
  AtlasPage(
    this.story, {
    this.args,
    this.id,
    this.label,
    this.decorators = const [],
  });

  final Story<TWidget, TArgs> story;
  final TArgs? args;

  /// The path segment of this page below its flow, e.g. `Atlas/Flow/<id>`.
  final String? id;

  /// The name shown on the node, defaulting to the story's name.
  final String? label;

  final List<AtlasNodeDecorator> decorators;

  String get name => label ?? story.name;

  String get pathSegment => id ?? label ?? story.name;

  /// This page's state as a [Scenario] of [story], so it renders like one.
  late final Scenario<TWidget, TArgs> scenario = Scenario<TWidget, TArgs>(
    name: pathSegment,
    args: args,
    excludeFromTests: true,
  )..story = story;

  @override
  bool operator ==(Object other) {
    if (other is! AtlasPage) return false;
    if (id != null || other.id != null) return id == other.id;
    return identical(story, other.story) && identical(args, other.args);
  }

  @override
  int get hashCode {
    return id?.hashCode ??
        Object.hash(identityHashCode(story), identityHashCode(args));
  }
}

/// A destination without a story, e.g. an external [url] or an action such as
/// logging out.
class AtlasTerminal implements AtlasNode {
  const AtlasTerminal({
    required this.label,
    this.url,
    this.description,
    this.decorators = const [],
  });

  final String label;

  /// Opened when the node is tapped.
  final String? url;

  final String? description;
  final List<AtlasNodeDecorator> decorators;
}

/// A named flow through the pages of an app, mapping each [AtlasNode] to the
/// nodes it leads to.
///
/// Flows are declared outside of the stories they reference, so two stories
/// can lead to each other without a circular initialization. [decorators]
/// wrap every node of the flow.
class AtlasFlow {
  AtlasFlow({
    required this.name,
    required this.links,
    this.decorators = const [],
  });

  final String name;
  final Map<AtlasNode, List<AtlasTarget>> links;
  final List<AtlasNodeDecorator> decorators;

  late final Map<AtlasNode, AtlasNode> _canonical = () {
    final canonical = <AtlasNode, AtlasNode>{};
    final targets = links.values.expand((targets) => targets).map(_nodeOf);
    for (final node in [...links.keys, ...targets]) {
      final normalized = _normalize(node);
      canonical.putIfAbsent(normalized, () => normalized);
    }
    return canonical;
  }();

  late final Map<AtlasNode, List<AtlasNode>> _links = {
    for (final MapEntry(key: from, value: targets) in links.entries)
      node(from): [for (final target in targets) node(_nodeOf(target))],
  };

  late final Map<(AtlasNode, AtlasNode), AtlasLink> _linkDetails = {
    for (final MapEntry(key: from, value: targets) in links.entries)
      for (final target in targets.whereType<AtlasLink>())
        (node(from), node(target.to)): target,
  };

  static AtlasNode _nodeOf(AtlasTarget target) {
    return switch (target) {
      final AtlasLink link => link.to,
      final AtlasNode node => node,
      _ => throw ArgumentError.value(target, 'target', 'Unsupported target'),
    };
  }

  static AtlasNode _normalize(AtlasNode node) {
    return switch (node) {
      final Story story => AtlasPage(story),
      final AtlasPage page => page,
      final AtlasTerminal terminal => terminal,
      _ => throw ArgumentError.value(node, 'node', 'Unsupported AtlasNode'),
    };
  }

  /// The node of this flow that [node] refers to, so that a [Story] and an
  /// `AtlasPage` of it without args or id resolve to the same node.
  AtlasNode node(AtlasNode node) {
    final normalized = _normalize(node);
    return _canonical[normalized] ?? normalized;
  }

  /// All nodes of this flow in declaration order, including nodes that only
  /// appear as a target.
  List<AtlasNode> get pages => _canonical.values.toList();

  List<AtlasNode> leadsTo(AtlasNode from) => _links[node(from)] ?? const [];

  /// The [AtlasLink] declared from [from] to [to], if the link is described.
  AtlasLink? linkBetween(AtlasNode from, AtlasNode to) {
    return _linkDetails[(node(from), node(to))];
  }

  bool get hasLinkLabels {
    return _linkDetails.values.any((link) => link.label != null);
  }

  List<AtlasNode> reachedFrom(AtlasNode to) {
    final target = node(to);
    return [
      for (final MapEntry(key: from, value: targets) in _links.entries)
        if (targets.contains(target)) from,
    ];
  }
}

/// Renders a live preview of every atlas page, framed by the viewport selected
/// in the `ViewportAddon`, or by [fallbackSize] when none is selected.
class AtlasPreviewConfig {
  const AtlasPreviewConfig({this.fallbackSize = const Size(390, 844)});

  final Size fallbackSize;
}
