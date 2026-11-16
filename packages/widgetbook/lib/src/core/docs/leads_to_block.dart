import 'package:flutter/material.dart';

import '../atlas/atlas_layout.dart';
import '../framework/framework.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that lists, per [Config.atlas] flow, which pages each story of
/// the current component leads to and is reached from. Renders nothing when
/// none of the component's stories is part of a flow.
class LeadsToDocBlock extends DocBlock {
  const LeadsToDocBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    assertAtlasStoriesRegistered(state.config);

    final entries = [
      for (final story in state.component!.stories)
        for (final flow in state.config.atlas)
          if (flow.pages.contains(story)) (story: story, flow: flow),
    ];

    if (entries.isEmpty) return const SizedBox.shrink();

    return ComposerDocBlock(
      children: [
        const SubtitleDocBlock(title: 'Leads to'),
        for (final (:story, :flow) in entries)
          _FlowLinks(story: story, flow: flow),
      ],
    );
  }
}

class _FlowLinks extends DocBlock {
  const _FlowLinks({required this.story, required this.flow});

  final Story story;
  final AtlasFlow flow;

  @override
  Widget build(BuildContext context) {
    final leadsTo = flow.leadsTo(story);
    final reachedFrom = flow.reachedFrom(story);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          '${story.name} · ${flow.name}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (leadsTo.isNotEmpty) _PageLinks(label: 'Leads to', pages: leadsTo),
        if (reachedFrom.isNotEmpty)
          _PageLinks(label: 'Reached from', pages: reachedFrom),
      ],
    );
  }
}

class _PageLinks extends StatelessWidget {
  const _PageLinks({required this.label, required this.pages});

  final String label;
  final List<Story> pages;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        for (final page in pages)
          ActionChip(
            label: Text('${page.component.name} / ${page.name}'),
            onPressed: () => state.goToStory(page),
          ),
      ],
    );
  }
}
