import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:meta/meta.dart';

import '../addons/addons.dart';
import '../framework/framework.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import 'atlas_layout.dart';
import 'atlas_navigation.dart';

const _columnGap = 72.0;
const _labeledColumnGap = 200.0;
const _rowGap = 20.0;
const _laneGap = 14.0;
const _labeledLaneGap = 28.0;
const _labelMaxWidth = 160.0;
const _portSpacing = 12.0;
const _labeledPortSpacing = 28.0;
const _textNodeSize = Size(176, 52);
const _previewNodeWidth = 200.0;
const _captionHeight = 48.0;

/// The positions of an [AtlasFlow]'s nodes and the overall [size] of its
/// graph, so the graph can be fitted into the available space before it is
/// built.
@internal
class AtlasGraphGeometry {
  factory AtlasGraphGeometry(AtlasFlow flow, {Size? previewSize}) {
    final nodeSize = previewSize == null
        ? _textNodeSize
        : Size(
            _previewNodeWidth,
            _previewNodeWidth * previewSize.height / previewSize.width +
                _captionHeight,
          );

    final columnGap = flow.hasLinkLabels ? _labeledColumnGap : _columnGap;
    final laneGap = flow.hasLinkLabels ? _labeledLaneGap : _laneGap;

    final layout = AtlasLayout(flow);
    final rects = <AtlasNode, Rect>{
      for (final (column, nodes) in layout.columns.indexed)
        for (final (row, node) in nodes.indexed)
          node:
              Offset(
                column * (nodeSize.width + columnGap),
                row * (nodeSize.height + _rowGap),
              ) &
              nodeSize,
    };

    final backLinkCount = [
      for (final from in flow.pages)
        for (final to in flow.leadsTo(from))
          if (layout.isBackLink(from, to)) to,
    ].length;

    final bottom = rects.values.fold(
      0.0,
      (max, rect) => math.max(max, rect.bottom),
    );
    final right = rects.values.fold(
      0.0,
      (max, rect) => math.max(max, rect.right),
    );

    return AtlasGraphGeometry._(
      layout,
      rects,
      previewSize,
      columnGap,
      laneGap,
      bottom,
      Size(right + 8, bottom + laneGap * (backLinkCount + 1)),
    );
  }

  AtlasGraphGeometry._(
    this.layout,
    this.rects,
    this.previewSize,
    this.columnGap,
    this.laneGap,
    this.nodesBottom,
    this.size,
  );

  final AtlasLayout layout;
  final Map<AtlasNode, Rect> rects;
  final Size? previewSize;
  final double columnGap;
  final double laneGap;
  final double nodesBottom;
  final Size size;
}

/// The size a page preview is rendered at: the viewport selected in the
/// [ViewportAddon], or the [AtlasPreviewConfig.fallbackSize].
@internal
Size? atlasPreviewSize(WidgetbookState state) {
  final preview = state.config.atlasPreview;
  if (preview == null) return null;

  final viewport = atlasSelectedViewport(state);
  if (viewport == null) return preview.fallbackSize;

  return Size(viewport.maxWidth, viewport.maxHeight);
}

/// The viewport selected in the [ViewportAddon], if it has a fixed size.
@internal
ViewportData? atlasSelectedViewport(WidgetbookState state) {
  final addon = state.config.addons?.whereType<ViewportAddon>().firstOrNull;
  final viewport = addon?.valueFromQueryGroup(
    state.queryGroups[addon.groupName],
  );

  if (viewport == null ||
      !viewport.maxWidth.isFinite ||
      !viewport.maxHeight.isFinite) {
    return null;
  }

  return viewport;
}

/// Draws the nodes of an [AtlasFlow] at the positions of [geometry],
/// connected by arrows to the nodes they lead to.
@internal
class AtlasFlowGraph extends StatelessWidget {
  const AtlasFlowGraph({
    super.key,
    required this.flow,
    required this.geometry,
  });

  final AtlasFlow flow;
  final AtlasGraphGeometry geometry;

  @override
  Widget build(BuildContext context) {
    final rects = geometry.rects;
    final theme = WidgetbookTheme.of(context);
    final registered = registeredStories(WidgetbookState.of(context).config);

    final ports = _ForwardPorts(
      flow,
      geometry,
      spacing: flow.hasLinkLabels ? _labeledPortSpacing : _portSpacing,
    );

    final placedLabels = <Rect>[];
    Size? labelSize(AtlasLink? link) {
      final label = link?.label;
      if (label == null) return null;

      final painter = TextPainter(
        text: TextSpan(text: label, style: theme.textTheme.bodySmall),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(maxWidth: _labelMaxWidth - 16);
      final size = Size(painter.width + 20, painter.height + 4);
      painter.dispose();
      return size;
    }

    final layout = geometry.layout;
    final links = [
      for (final from in flow.pages)
        for (final to in flow.leadsTo(from)) (from, to),
    ];
    int span((AtlasNode, AtlasNode) link) {
      return layout.columnOf(link.$2) - layout.columnOf(link.$1);
    }

    final forwardLinks =
        links.where((link) => !layout.isBackLink(link.$1, link.$2)).toList()
          ..sort((a, b) => span(a).compareTo(span(b)));

    var lanes = 0;
    final edges = [
      for (final (from, to) in links)
        if (layout.isBackLink(from, to))
          _Edge.back(
            from: rects[from]!,
            to: rects[to]!,
            laneY: geometry.nodesBottom + geometry.laneGap * ++lanes,
            link: flow.linkBetween(from, to),
          ),
      for (final (from, to) in forwardLinks)
        _Edge.forward(
          start: ports.start(from, to),
          end: ports.end(from, to),
          link: flow.linkBetween(from, to),
          labelSize: labelSize(flow.linkBetween(from, to)),
          nodes: rects.values,
          placedLabels: placedLabels,
        ),
    ];

    return SizedBox.fromSize(
      size: geometry.size,
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
          for (final MapEntry(key: node, value: rect) in rects.entries)
            Positioned.fromRect(
              rect: rect,
              child: _AtlasNodeView(
                flow: flow,
                node: node,
                previewSize: geometry.previewSize,
                isUnregistered: isUnregisteredPage(node, registered),
              ),
            ),
          for (final edge in edges)
            if (edge.link case AtlasLink(:final label?))
              Positioned(
                left: edge.labelAnchor.dx,
                top: edge.labelAnchor.dy,
                child: FractionalTranslation(
                  translation: const Offset(-0.5, -0.5),
                  child: _LinkLabel(
                    label: label,
                    description: edge.link!.description,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

/// Spreads the forward links of each node over its sides, ordered by where
/// the other end of each link is, so links and their labels do not share a
/// single point.
class _ForwardPorts {
  _ForwardPorts(AtlasFlow flow, this.geometry, {required this.spacing}) {
    final links = [
      for (final from in flow.pages)
        for (final to in flow.leadsTo(from))
          if (!geometry.layout.isBackLink(from, to)) (from, to),
    ];

    for (final node in flow.pages) {
      final outgoing = links.where((link) => link.$1 == node).toList()
        ..sort((a, b) => _y(a.$2).compareTo(_y(b.$2)));
      final incoming = links.where((link) => link.$2 == node).toList()
        ..sort((a, b) => _y(a.$1).compareTo(_y(b.$1)));

      for (final (index, link) in outgoing.indexed) {
        _starts[link] = _port(node, index, outgoing.length);
      }
      for (final (index, link) in incoming.indexed) {
        _ends[link] = _port(node, index, incoming.length);
      }
    }
  }

  final AtlasGraphGeometry geometry;
  final double spacing;
  final _starts = <(AtlasNode, AtlasNode), double>{};
  final _ends = <(AtlasNode, AtlasNode), double>{};

  double _y(AtlasNode node) => geometry.rects[node]!.center.dy;

  double _port(AtlasNode node, int index, int count) {
    final rect = geometry.rects[node]!;
    final step = math.min(spacing, (rect.height - 8) / count);
    return rect.center.dy + (index - (count - 1) / 2) * step;
  }

  Offset start(AtlasNode from, AtlasNode to) {
    return Offset(geometry.rects[from]!.right, _starts[(from, to)]!);
  }

  Offset end(AtlasNode from, AtlasNode to) {
    return Offset(geometry.rects[to]!.left, _ends[(from, to)]!);
  }
}

class _LinkLabel extends StatelessWidget {
  const _LinkLabel({required this.label, required this.description});

  final String label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = WidgetbookTheme.of(context);

    final pill = Material(
      color: theme.colorScheme.surface,
      shape: StadiumBorder(
        side: BorderSide(color: theme.dividerColor.withAlpha(140)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _labelMaxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ),
    );

    return Tooltip(message: description ?? label, child: pill);
  }
}

class _AtlasNodeView extends StatefulWidget {
  const _AtlasNodeView({
    required this.flow,
    required this.node,
    required this.previewSize,
    required this.isUnregistered,
  });

  final AtlasFlow flow;
  final AtlasNode node;
  final Size? previewSize;
  final bool isUnregistered;

  @override
  State<_AtlasNodeView> createState() => _AtlasNodeViewState();
}

class _AtlasNodeViewState extends State<_AtlasNodeView> {
  var _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final card = switch (node) {
      AtlasTerminal() => _TerminalCard(terminal: node),
      AtlasPage() when widget.isUnregistered => _PlaceholderCard(page: node),
      AtlasPage() => _PageCard(
        page: node,
        previewSize: widget.previewSize,
        isLive: _isHovered,
      ),
      _ => const SizedBox.shrink(),
    };

    final decorators = [
      ...switch (node) {
        AtlasPage(:final decorators) => decorators,
        AtlasTerminal(:final decorators) => decorators,
        _ => const <AtlasNodeDecorator>[],
      },
      ...widget.flow.decorators,
    ];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.isUnregistered
            ? null
            : () => openAtlasNode(context, widget.flow, node),
        child: decorators.fold<Widget>(
          card,
          (child, decorator) => decorator(context, node, child),
        ),
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({required this.child, this.isMuted = false});

  final Widget child;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final theme = WidgetbookTheme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      color: isMuted ? theme.colorScheme.surfaceContainerHighest : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.dividerColor.withAlpha(100)),
      ),
      child: child,
    );
  }
}

/// A muted card as tall as a text-only node, centered in its slot so links
/// still meet it in the middle.
class _CompactNodeCard extends StatelessWidget {
  const _CompactNodeCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: _textNodeSize.height,
        child: _NodeCard(isMuted: true, child: child),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.title, this.subtitle, this.icon});

  final String title;
  final String? subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = WidgetbookTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null)
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(120),
                    ),
                  ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageCard extends StatelessWidget {
  const _PageCard({
    required this.page,
    required this.previewSize,
    required this.isLive,
  });

  final AtlasPage page;
  final Size? previewSize;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    final caption = _Caption(
      title: page.name,
      subtitle: page.story.component.name,
    );

    final previewSize = this.previewSize;
    if (previewSize == null) return _NodeCard(child: caption);

    return _NodeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _Preview(page: page, size: previewSize, isLive: isLive),
          ),
          SizedBox(height: _captionHeight, child: caption),
        ],
      ),
    );
  }
}

/// Renders [page] like the workbench does, through the app builder, addons and
/// story setup, scaled down from [size]. The selected viewport is applied
/// without its frame, as the node itself is the viewport. Animations only run
/// while [isLive].
class _Preview extends StatelessWidget {
  const _Preview({
    required this.page,
    required this.size,
    required this.isLive,
  });

  final AtlasPage page;
  final Size size;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final config = state.config;
    final viewport = atlasSelectedViewport(state);
    final modes = [
      if (viewport != null) ViewportMode(viewport),
      if (page.args != null) ...page.scenario.modes,
    ];

    return ClipRect(
      child: IgnorePointer(
        child: TickerMode(
          enabled: isLive,
          child: FittedBox(
            child: SizedBox.fromSize(
              size: size,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(size: size),
                child: RepaintBoundary(
                  child: page.story.buildWithConfig(
                    context,
                    config,
                    args: page.args,
                    modes: modes,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TerminalCard extends StatelessWidget {
  const _TerminalCard({required this.terminal});

  final AtlasTerminal terminal;

  @override
  Widget build(BuildContext context) {
    return _CompactNodeCard(
      child: Center(
        child: Tooltip(
          message: terminal.description ?? terminal.url ?? '',
          child: _Caption(
            title: terminal.label,
            subtitle: terminal.description,
            icon: terminal.url == null
                ? Icons.flag_outlined
                : Icons.open_in_new,
          ),
        ),
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  const _PlaceholderCard({required this.page});

  final AtlasPage page;

  @override
  Widget build(BuildContext context) {
    return _CompactNodeCard(
      child: Center(
        child: _Caption(
          title: page.label ?? 'Unregistered story',
          subtitle: 'Not in Config.components',
          icon: Icons.help_outline,
        ),
      ),
    );
  }
}

/// A link drawn as [path], ending in an arrowhead at [tip] that points in
/// [direction] (radians). Its [link]'s label is shown at [labelAnchor].
class _Edge {
  _Edge._(this.path, this.tip, this.direction, this.labelAnchor, this.link);

  /// Runs from [start] on the right side of a node to [end] on the left side
  /// of a later one as one continuous curve. It leaves and arrives
  /// horizontally, so the line meets the node at a right angle, like its
  /// arrowhead. Its label of [labelSize] sits in the middle of the curve, or
  /// as close to it as possible without covering [nodes] and, if possible,
  /// the [placedLabels], to which its own area is then added.
  factory _Edge.forward({
    required Offset start,
    required Offset end,
    required AtlasLink? link,
    required Size? labelSize,
    required Iterable<Rect> nodes,
    required List<Rect> placedLabels,
  }) {
    final bend = Offset((end.dx - start.dx) / 2, 0);
    final control1 = start + bend;
    final control2 = end - bend;

    Offset pointAt(double t) {
      final u = 1 - t;
      return start * (u * u * u) +
          control1 * (3 * u * u * t) +
          control2 * (3 * u * t * t) +
          end * (t * t * t);
    }

    int costAt(Offset point) {
      final label = Rect.fromCenter(
        center: point,
        width: labelSize!.width,
        height: labelSize.height,
      );
      return nodes.where(label.overlaps).length * 100 +
          placedLabels.where(label.overlaps).length;
    }

    final candidates = [
      for (var step = 0; step <= 20; step++)
        for (final t in {0.5 - step / 40, 0.5 + step / 40}) pointAt(t),
    ];

    var labelAnchor = pointAt(0.5);
    if (labelSize != null) {
      var lowest = costAt(labelAnchor);
      for (final point in candidates) {
        if (lowest == 0) break;
        final cost = costAt(point);
        if (cost < lowest) {
          lowest = cost;
          labelAnchor = point;
        }
      }
      placedLabels.add(
        Rect.fromCenter(
          center: labelAnchor,
          width: labelSize.width,
          height: labelSize.height,
        ),
      );
    }

    return _Edge._(
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
      end,
      0,
      labelAnchor,
      link,
    );
  }

  /// Runs below all nodes along its own lane at [laneY], so back links do not
  /// cross nodes or overlap each other.
  factory _Edge.back({
    required Rect from,
    required Rect to,
    required double laneY,
    required AtlasLink? link,
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
      Offset((start.dx + end.dx) / 2, laneY),
      link,
    );
  }

  final Path path;
  final Offset tip;
  final double direction;
  final Offset labelAnchor;
  final AtlasLink? link;
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
