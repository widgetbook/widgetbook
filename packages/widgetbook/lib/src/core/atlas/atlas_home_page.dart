import 'package:flutter/material.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import 'atlas_flow_graph.dart';
import 'atlas_layout.dart';

/// Shows every [Config.atlas] flow as a graph of its pages. Tapping a page
/// navigates to its story.
///
/// This is the default home page when [Config.atlas] is not empty. Use it
/// directly to embed the atlas in a custom [Config.home].
class AtlasHomePage extends StatelessWidget {
  const AtlasHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final config = WidgetbookState.of(context).config;
    assertAtlasStoriesRegistered(config);

    final theme = WidgetbookTheme.of(context);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Atlas', style: theme.textTheme.displaySmall),
        for (final flow in config.atlas) ...[
          const SizedBox(height: 32),
          Text(flow.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AtlasFlowGraph(flow: flow),
          ),
        ],
      ],
    );
  }
}
