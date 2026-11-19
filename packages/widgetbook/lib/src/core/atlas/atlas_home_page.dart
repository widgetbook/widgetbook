import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import 'atlas_flow_graph.dart';

const _overviewGraphHeight = 480.0;

/// Shows [flows], or every [Config.atlas] flow, as graphs of their pages.
/// Tapping a page navigates to it; graphs can be panned and zoomed.
///
/// This is the default home page when [Config.atlas] is not empty. Use it
/// directly to embed the atlas in a custom [Config.home].
class AtlasHomePage extends StatelessWidget {
  const AtlasHomePage({super.key, this.flows});

  /// The flows to show, or all of [Config.atlas] when null.
  final List<AtlasFlow>? flows;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final theme = WidgetbookTheme.of(context);
    final flows = this.flows ?? state.config.atlas;
    final previewSize = atlasPreviewSize(state);

    if (this.flows != null && flows.length == 1) {
      final flow = flows.single;

      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(flow.name, style: theme.textTheme.displaySmall),
            const SizedBox(height: 24),
            Expanded(
              child: _ZoomableGraph(flow: flow, previewSize: previewSize),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Atlas', style: theme.textTheme.displaySmall),
        for (final flow in flows) ...[
          const SizedBox(height: 32),
          Text(flow.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          SizedBox(
            height: _overviewGraphHeight,
            child: _ZoomableGraph(flow: flow, previewSize: previewSize),
          ),
        ],
      ],
    );
  }
}

/// Fits the graph of [flow] into the available space and lets it be panned
/// and zoomed.
class _ZoomableGraph extends StatefulWidget {
  const _ZoomableGraph({required this.flow, required this.previewSize});

  final AtlasFlow flow;
  final Size? previewSize;

  @override
  State<_ZoomableGraph> createState() => _ZoomableGraphState();
}

class _ZoomableGraphState extends State<_ZoomableGraph> {
  final _controller = TransformationController();
  Size? _fittedViewport;
  Size? _fittedGraph;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fit(Size viewport, Size graph) {
    final scale = math.min(
      1.0,
      math.min(viewport.width / graph.width, viewport.height / graph.height),
    );
    final dx = math.max(0.0, (viewport.width - graph.width * scale) / 2);

    _controller.value = Matrix4.identity()
      ..translateByDouble(dx, 0, 0, 1)
      ..scaleByDouble(scale, scale, 1, 1);
    _fittedViewport = viewport;
    _fittedGraph = graph;
  }

  void _zoom(double factor, Size viewport) {
    final center = viewport.center(Offset.zero);
    _controller.value = Matrix4.identity()
      ..translateByDouble(center.dx, center.dy, 0, 1)
      ..scaleByDouble(factor, factor, 1, 1)
      ..translateByDouble(-center.dx, -center.dy, 0, 1)
      ..multiply(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    final geometry = AtlasGraphGeometry(
      widget.flow,
      previewSize: widget.previewSize,
    );
    final theme = WidgetbookTheme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewport = constraints.biggest;
        if (viewport != _fittedViewport || geometry.size != _fittedGraph) {
          _fit(viewport, geometry.size);
        }

        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: theme.dividerColor.withAlpha(100)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Positioned.fill(
                  child: InteractiveViewer(
                    transformationController: _controller,
                    constrained: false,
                    minScale: 0.05,
                    maxScale: 4,
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    child: AtlasFlowGraph(
                      flow: widget.flow,
                      geometry: geometry,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Zoom out',
                          icon: const Icon(Icons.remove),
                          onPressed: () => _zoom(1 / 1.25, viewport),
                        ),
                        IconButton(
                          tooltip: 'Fit to screen',
                          icon: const Icon(Icons.fit_screen_outlined),
                          onPressed: () => _fit(viewport, geometry.size),
                        ),
                        IconButton(
                          tooltip: 'Zoom in',
                          icon: const Icon(Icons.add),
                          onPressed: () => _zoom(1.25, viewport),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
