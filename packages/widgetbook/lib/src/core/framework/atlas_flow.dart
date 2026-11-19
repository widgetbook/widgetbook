/// @docImport 'config.dart';
library;

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

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

/// A state of an [AtlasFlow], e.g. logged in or guest, with [links] of its
/// own in addition to the links of the flow.
class AtlasFlowVariant {
  const AtlasFlowVariant({
    required this.name,
    required this.links,
  });

  final String name;
  final Map<AtlasNode, List<AtlasTarget>> links;
}

/// A named section of an [AtlasFlow], e.g. a step of an onboarding, shown as
/// a header above its [pages].
class AtlasGroup {
  const AtlasGroup({
    required this.name,
    required this.pages,
  });

  final String name;
  final List<AtlasNode> pages;
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
    this.links = const {},
    this.variants = const [],
    this.decorators = const [],
    this.groups = const [],
  }) : parent = null,
       _linkMaps = [links];

  AtlasFlow._derived(
    AtlasFlow this.parent, {
    required this.name,
    required List<Map<AtlasNode, List<AtlasTarget>>> linkMaps,
  }) : links = {for (final map in linkMaps) ...map},
       variants = const [],
       decorators = parent.decorators,
       groups = parent.groups,
       _linkMaps = linkMaps;

  final String name;

  /// The links of this flow; with [variants], the links all of them share.
  final Map<AtlasNode, List<AtlasTarget>> links;

  /// States of this flow, e.g. logged in and guest, each adding its own
  /// links to [links]. Each is listed below the flow in the navigation tree.
  final List<AtlasFlowVariant> variants;

  /// Sections laid out left to right in this order. A node belongs to the
  /// first group listing it; nodes of no group follow the groups.
  final List<AtlasGroup> groups;
  final List<AtlasNodeDecorator> decorators;

  /// The flow this variant belongs to, or `null` if this is not a variant.
  @internal
  final AtlasFlow? parent;

  final List<Map<AtlasNode, List<AtlasTarget>>> _linkMaps;

  Iterable<MapEntry<AtlasNode, List<AtlasTarget>>> get _entries {
    return _linkMaps.expand((map) => map.entries);
  }

  /// The [variants] as flows of their own, including the shared [links].
  @internal
  late final List<AtlasFlow> variantFlows = [
    for (final variant in variants)
      AtlasFlow._derived(
        this,
        name: variant.name,
        linkMaps: [links, variant.links],
      ),
  ];

  /// The flow whose layout is used for this one: with variants, the links of
  /// all variants combined, so that nodes keep their position across them.
  @internal
  late final AtlasFlow layoutFlow = () {
    final root = parent ?? this;
    if (root.variants.isEmpty) return this;
    if (parent != null) return parent!.layoutFlow;

    return AtlasFlow._derived(
      this,
      name: name,
      linkMaps: [links, for (final variant in variants) variant.links],
    );
  }();

  late final Map<AtlasNode, AtlasNode> _canonical = () {
    final canonical = <AtlasNode, AtlasNode>{};
    final froms = _entries.map((entry) => entry.key);
    final targets = _entries.expand((entry) => entry.value).map(_nodeOf);
    final grouped = groups.expand((group) => group.pages);
    for (final node in [...froms, ...targets, ...grouped]) {
      final normalized = _normalize(node);
      canonical.putIfAbsent(normalized, () => normalized);
    }
    return canonical;
  }();

  late final Map<AtlasNode, List<AtlasNode>> _links = () {
    final links = <AtlasNode, List<AtlasNode>>{};
    for (final MapEntry(key: from, value: targets) in _entries) {
      final existing = links.putIfAbsent(node(from), () => []);
      for (final target in targets.map(_nodeOf).map(node)) {
        if (!existing.contains(target)) existing.add(target);
      }
    }
    return links;
  }();

  late final Map<(AtlasNode, AtlasNode), AtlasLink> _linkDetails = {
    for (final MapEntry(key: from, value: targets) in _entries)
      for (final target in targets.whereType<AtlasLink>())
        (node(from), node(target.to)): target,
  };

  late final Map<AtlasNode, AtlasGroup> _groupOf = () {
    final groupOf = <AtlasNode, AtlasGroup>{};
    for (final group in groups) {
      for (final page in group.pages) {
        groupOf.putIfAbsent(node(page), () => group);
      }
    }
    return groupOf;
  }();

  AtlasGroup? groupOf(AtlasNode node) => _groupOf[this.node(node)];

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
  /// appear as a target or in a group.
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
