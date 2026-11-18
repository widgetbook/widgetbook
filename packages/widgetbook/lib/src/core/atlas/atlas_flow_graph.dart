import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import 'atlas_layout.dart';

const _nodeSize = Size(176, 52);
const _columnGap = 72.0;
const _rowGap = 20.0;
const _laneGap = 14.0;

/// Draws the pages of an [AtlasFlow] as tappable nodes, laid out left to right
/// by [AtlasLayout], connected by arrows to the pages they lead to.
@internal
class AtlasFlowGraph extends StatelessWidget {
  const AtlasFlowGraph({super.key, required this.flow});

  final AtlasFlow flow;

  @override
  Widget build(BuildContext context) {
    final layout = AtlasLayout(flow);
    final rects = <Story, Rect>{
      for (final (column, pages) in layout.columns.indexed)
        for (final (row, page) in pages.indexed)
          page:
              Offset(
                column * (_nodeSize.width + _columnGap),
                row * (_nodeSize.height + _rowGap),
              ) &
              _nodeSize,
    };

    if (rects.isEmpty) return const SizedBox.shrink();

    final bounds = rects.values.reduce((a, b) => a.expandToInclude(b));
    var lanes = 0;
    final edges = [
      for (final MapEntry(key: from, value: targets) in flow.links.entries)
        for (final to in targets)
          layout.isBackLink(from, to)
              ? _Edge.back(
                  from: rects[from]!,
                  to: rects[to]!,
                  laneY: bounds.bottom + _laneGap * ++lanes,
                )
              : _Edge.forward(from: rects[from]!, to: rects[to]!),
    ];

    final theme = WidgetbookTheme.of(context);

    return SizedBox(
      width: bounds.right + 8,
      height: bounds.bottom + _laneGap * (lanes + 1),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _EdgePainter(
                edges: edges,
                color: theme.colorScheme.onSurface.withAlpha(140),
              ),
            ),
          ),
          for (final MapEntry(key: page, value: rect) in rects.entries)
            Positioned.fromRect(
              rect: rect,
              child: _AtlasNode(page: page),
            ),
        ],
      ),
    );
  }
}

class _AtlasNode extends StatelessWidget {
  const _AtlasNode({required this.page});

  final Story page;

  @override
  Widget build(BuildContext context) {
    final theme = WidgetbookTheme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.dividerColor.withAlpha(100)),
      ),
      child: InkWell(
        onTap: () => WidgetbookState.of(context).goToStory(page),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                page.component.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(120),
                ),
              ),
              Text(
                page.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A link drawn as [path], ending in an arrowhead at [tip] that points in
/// [direction] (radians).
class _Edge {
  _Edge._(this.path, this.tip, this.direction);

  /// Runs from the right side of a page to the left side of a later one.
  factory _Edge.forward({required Rect from, required Rect to}) {
    final start = from.centerRight;
    final end = to.centerLeft;
    final bend = math.min(_columnGap, end.dx - start.dx) / 2;

    return _Edge._(
      Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(
          start.dx + bend,
          start.dy,
          end.dx - bend,
          end.dy,
          end.dx,
          end.dy,
        ),
      end,
      0,
    );
  }

  /// Runs below all pages along its own lane at [laneY], so back links do not
  /// cross pages or overlap each other.
  factory _Edge.back({
    required Rect from,
    required Rect to,
    required double laneY,
  }) {
    final start = from.bottomCenter + Offset(from.width / 6, 0);
    final end = to.bottomCenter - Offset(to.width / 6, 0);

    return _Edge._(
      Path()
        ..moveTo(start.dx, start.dy)
        ..lineTo(start.dx, laneY)
        ..lineTo(end.dx, laneY)
        ..lineTo(end.dx, end.dy),
      end,
      -math.pi / 2,
    );
  }

  final Path path;
  final Offset tip;
  final double direction;
}

class _EdgePainter extends CustomPainter {
  const _EdgePainter({required this.edges, required this.color});

  final List<_Edge> edges;
  final Color color;

  static const _arrowLength = 8.0;
  static const _arrowAngle = math.pi / 7;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (final edge in edges) {
      canvas.drawPath(edge.path, paint);

      for (final side in [-1, 1]) {
        canvas.drawLine(
          edge.tip,
          edge.tip -
              Offset.fromDirection(
                edge.direction + side * _arrowAngle,
                _arrowLength,
              ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_EdgePainter oldDelegate) {
    return oldDelegate.edges != edges || oldDelegate.color != color;
  }
}
