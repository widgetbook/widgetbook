import 'package:material_ui/material_ui.dart';

import '../atlas/atlas_layout.dart';
import '../atlas/atlas_navigation.dart';
import '../framework/framework.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that lists, per [Config.atlas] flow, which nodes each page of
/// the current component's stories leads to and is reached from. Renders
/// nothing when none of the component's stories is part of a flow.
class LeadsToDocBlock extends DocBlock {
  const LeadsToDocBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final stories = state.component!.stories.toSet();

    final entries = [
      for (final flow in state.config.atlas)
        for (final node in flow.pages)
          if (node is AtlasPage && stories.contains(node.story))
            (page: node, flow: flow),
    ];

    if (entries.isEmpty) return const SizedBox.shrink();

    return ComposerDocBlock(
      children: [
        const SubtitleDocBlock(title: 'Leads to'),
        for (final (:page, :flow) in entries)
          _FlowLinks(page: page, flow: flow),
      ],
    );
  }
}

class _FlowLinks extends DocBlock {
  const _FlowLinks({required this.page, required this.flow});

  final AtlasPage page;
  final AtlasFlow flow;

  @override
  Widget build(BuildContext context) {
    final leadsTo = flow.leadsTo(page);
    final reachedFrom = flow.reachedFrom(page);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          '${page.name} · ${flow.name}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (leadsTo.isNotEmpty)
          _NodeLinks(label: 'Leads to', flow: flow, nodes: leadsTo),
        if (reachedFrom.isNotEmpty)
          _NodeLinks(label: 'Reached from', flow: flow, nodes: reachedFrom),
      ],
    );
  }
}

class _NodeLinks extends StatelessWidget {
  const _NodeLinks({
    required this.label,
    required this.flow,
    required this.nodes,
  });

  final String label;
  final AtlasFlow flow;
  final List<AtlasNode> nodes;

  @override
  Widget build(BuildContext context) {
    final registered = registeredStories(WidgetbookState.of(context).config);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        for (final node in nodes)
          ActionChip(
            label: Text(switch (node) {
              AtlasTerminal(:final label) => label,
              AtlasPage(:final label)
                  when isUnregisteredPage(node, registered) =>
                label ?? 'Unregistered story',
              AtlasPage() => '${node.story.component.name} / ${node.name}',
              _ => '',
            }),
            onPressed: isUnregisteredPage(node, registered)
                ? null
                : () => openAtlasNode(context, flow, node),
          ),
      ],
    );
  }
}
