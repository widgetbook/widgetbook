import 'package:flutter/material.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import 'atlas_flow_graph.dart';
import 'atlas_layout.dart';

/// Shows [flows], or every [Config.atlas] flow, as graphs of their pages.
/// Tapping a page navigates to its story.
///
/// This is the default home page when [Config.atlas] is not empty. Use it
/// directly to embed the atlas in a custom [Config.home].
class AtlasHomePage extends StatelessWidget {
  const AtlasHomePage({super.key, this.flows});

  /// The flows to show, or all of [Config.atlas] when null.
  final List<AtlasFlow>? flows;

  @override
  Widget build(BuildContext context) {
    final config = WidgetbookState.of(context).config;
    assertAtlasStoriesRegistered(config);

    final theme = WidgetbookTheme.of(context);
    final flows = this.flows ?? config.atlas;
    final singleFlow = flows.length == 1 && this.flows != null;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          singleFlow ? flows.single.name : 'Atlas',
          style: theme.textTheme.displaySmall,
        ),
        for (final flow in flows) ...[
          const SizedBox(height: 32),
          if (!singleFlow) ...[
            Text(flow.name, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
          ],
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AtlasFlowGraph(flow: flow),
          ),
        ],
      ],
    );
  }
}
