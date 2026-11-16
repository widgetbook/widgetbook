import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import 'atlas_layout.dart';

const _nodeSize = Size(200, 56);
const _columnGap = 96.0;
const _rowGap = 24.0;
const _loopDepth = 32.0;

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

    final edges = [
      for (final MapEntry(key: from, value: targets) in flow.links.entries)
        for (final to in targets)
          _Edge(
            from: rects[from]!,
            to: rects[to]!,
            direction: _EdgeDirection.of(
              layout.columnOf(from),
              layout.columnOf(to),
              isSelfLink: from == to,
            ),
          ),
    ];

    final bounds = rects.values.reduce((a, b) => a.expandToInclude(b));
    final theme = WidgetbookTheme.of(context);

    return SizedBox(
      width: bounds.right + _columnGap / 2,
      height: bounds.bottom + _loopDepth + _rowGap,
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

enum _EdgeDirection {
  forward,
  sameColumn,
  backward;

  static _EdgeDirection of(
    int fromColumn,
    int toColumn, {
    required bool isSelfLink,
  }) {
    if (isSelfLink || toColumn < fromColumn) return backward;
    if (toColumn == fromColumn) return sameColumn;
    return forward;
  }
}

class _Edge {
  const _Edge({required this.from, required this.to, required this.direction});

  final Rect from;
  final Rect to;
  final _EdgeDirection direction;

  /// Forward links run from the right side of a page to the left side of the
  /// next one; all others loop around so they do not cross the pages between.
  (Offset, Offset, Offset, Offset) get curve {
    switch (direction) {
      case _EdgeDirection.forward:
        final start = from.centerRight;
        final end = to.centerLeft;
        const bend = Offset(_columnGap / 2, 0);
        return (start, start + bend, end - bend, end);
      case _EdgeDirection.sameColumn:
        final start = from.centerRight;
        final end = to.centerRight;
        const bend = Offset(_columnGap / 2, 0);
        return (start, start + bend, end + bend, end);
      case _EdgeDirection.backward:
        final start = from.bottomCenter + Offset(from.width / 6, 0);
        final end = to.bottomCenter - Offset(to.width / 6, 0);
        final bottom = math.max(start.dy, end.dy) + _loopDepth;
        return (start, Offset(start.dx, bottom), Offset(end.dx, bottom), end);
    }
  }
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
      final (start, control1, control2, end) = edge.curve;

      canvas.drawPath(
        Path()
          ..moveTo(start.dx, start.dy)
          ..cubicTo(
            control1.dx,
            control1.dy,
            control2.dx,
            control2.dy,
            end.dx,
            end.dy,
          ),
        paint,
      );

      final angle = (end - control2).direction;
      for (final side in [-1, 1]) {
        canvas.drawLine(
          end,
          end -
              Offset.fromDirection(
                angle + side * _arrowAngle,
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
