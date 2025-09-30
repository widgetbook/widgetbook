import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
// ignore: unnecessary_import flutter(<3.35.0)
import 'package:meta/meta.dart';

extension on SemanticsNode {
  /// Finds the first child [SemanticsNode] that matches the given [predicate].
  SemanticsNode? find(bool Function(SemanticsNode) predicate) {
    if (predicate(this)) {
      return this;
    }

    SemanticsNode? foundNode;

    visitChildren((child) {
      foundNode = child.find(predicate);
      return foundNode == null; // Stop visiting if found
    });

    return foundNode;
  }
}

/// A minimal copy of the [SemanticsDebugger] widget that is optimized
/// for Widgetbook and does not have the pointer functionality.
///
/// The major difference is that the root semantics node is not
/// the root node of the semantics tree, but a node that is
/// identified by the [rootIdentifier].
@internal
class MinimalSemanticsDebugger extends StatefulWidget {
  /// Creates a widget that visualizes the semantics for the child.
  ///
  /// [labelStyle] dictates the [TextStyle] used for the semantics labels.
  const MinimalSemanticsDebugger({
    super.key,
    required this.child,
    required this.rootIdentifier,
    this.labelStyle = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 10.0,
      height: 0.8,
    ),
  });

  final Widget child;
  final TextStyle labelStyle;
  final String rootIdentifier;

  @override
  State<MinimalSemanticsDebugger> createState() =>
      _MinimalSemanticsDebuggerState();
}

class _MinimalSemanticsDebuggerState extends State<MinimalSemanticsDebugger>
    with WidgetsBindingObserver {
  PipelineOwner? _pipelineOwner;
  SemanticsHandle? _semanticsHandle;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _semanticsHandle = SemanticsBinding.instance.ensureSemantics();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newOwner = View.pipelineOwnerOf(context);
    assert(newOwner.semanticsOwner != null);
    if (newOwner != _pipelineOwner) {
      _pipelineOwner?.semanticsOwner?.removeListener(_update);
      newOwner.semanticsOwner!.addListener(_update);
      _pipelineOwner = newOwner;
    }
  }

  @override
  void dispose() {
    _pipelineOwner?.semanticsOwner?.removeListener(_update);
    _semanticsHandle?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      // The root transform may have changed, we have to repaint.
    });
  }

  void _update() {
    _generation++;
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // Semantic information are only available at the end of a frame and our
        // only chance to paint them on the screen is the next frame. To achieve
        // this, we call setState() in a post-frame callback.
        if (mounted) {
          // If we got disposed this frame, we will still get an update,
          // because the inactive list is flushed after the semantics updates
          // are transmitted to the semantics clients.
          setState(() {
            // The generation of the _SemanticsDebuggerListener has changed.
          });
        }
      },
      debugLabel: 'SemanticsDebugger.update',
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: SemanticsDebuggerPainter(
        _pipelineOwner!,
        _generation,
        View.of(context).devicePixelRatio,
        widget.labelStyle,
        widget.rootIdentifier,
      ),
      // NOTE: this is different from the original SemanticsDebugger, which uses
      // a GestureDetector to handle pointer events. We don't need that here.
      child: widget.child,
    );
  }
}

@internal
class SemanticsDebuggerPainter extends CustomPainter {
  const SemanticsDebuggerPainter(
    this.owner,
    this.generation,
    this.devicePixelRatio,
    this.labelStyle,
    this.rootIdentifier,
  );

  final PipelineOwner owner;
  final int generation;
  final double devicePixelRatio;
  final TextStyle labelStyle;
  final String rootIdentifier;

  // NOTE: this is different from the original SemanticsDebugger, which uses
  // the root semantics node. Here we use the boundaries of the addon as a
  // root, to prevent layout shifting.
  // https://github.com/widgetbook/widgetbook/issues/1140
  SemanticsNode? get _rootSemanticsNode {
    final rootNode = owner.semanticsOwner?.rootSemanticsNode?.find(
      (node) => node.identifier == rootIdentifier,
    );

    return rootNode;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rootNode = _rootSemanticsNode;

    canvas.save();

    if (rootNode != null) {
      _paint(canvas, rootNode, _findDepth(rootNode), 0, 0);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(SemanticsDebuggerPainter oldDelegate) {
    return owner != oldDelegate.owner || generation != oldDelegate.generation;
  }

  @visibleForTesting
  String getMessage(SemanticsNode node) {
    final data = node.getSemanticsData();
    final annotations = <String>[];

    var wantsTap = false;

    // ignore: deprecated_member_use flutter(<3.35.0)
    if (data.hasFlag(SemanticsFlag.hasCheckedState)) {
      annotations.add(
        // ignore: deprecated_member_use flutter(<3.35.0)
        data.hasFlag(SemanticsFlag.isChecked) ? 'checked' : 'unchecked',
      );
      wantsTap = true;
    }

    // ignore: deprecated_member_use flutter(<3.35.0)
    if (data.hasFlag(SemanticsFlag.hasSelectedState)) {
      annotations.add(
        // ignore: deprecated_member_use flutter(<3.35.0)
        data.hasFlag(SemanticsFlag.isSelected) ? 'selected' : 'unselected',
      );
      wantsTap = true;
    }

    // ignore: deprecated_member_use flutter(<3.35.0)
    if (data.hasFlag(SemanticsFlag.isTextField)) {
      annotations.add('textfield');
      wantsTap = true;
    }

    if (data.hasAction(SemanticsAction.tap)) {
      if (!wantsTap) {
        annotations.add('button');
      }
    } else {
      if (wantsTap) {
        annotations.add('disabled');
      }
    }

    if (data.hasAction(SemanticsAction.longPress)) {
      annotations.add('long-pressable');
    }

    final isScrollable =
        data.hasAction(SemanticsAction.scrollLeft) ||
        data.hasAction(SemanticsAction.scrollRight) ||
        data.hasAction(SemanticsAction.scrollUp) ||
        data.hasAction(SemanticsAction.scrollDown);

    final isAdjustable =
        data.hasAction(SemanticsAction.increase) ||
        data.hasAction(SemanticsAction.decrease);

    if (isScrollable) {
      annotations.add('scrollable');
    }

    if (isAdjustable) {
      annotations.add('adjustable');
    }

    final String message;
    // Android will avoid pronouncing duplicating tooltip and label.
    // Therefore, having two identical strings is the same as having a single
    // string.
    final shouldIgnoreDuplicatedLabel =
        defaultTargetPlatform == TargetPlatform.android &&
        data.attributedLabel.string == data.tooltip;
    final tooltipAndLabel = <String>[
      if (data.tooltip.isNotEmpty) data.tooltip,
      if (data.attributedLabel.string.isNotEmpty &&
          !shouldIgnoreDuplicatedLabel)
        data.attributedLabel.string,
    ].join('\n');
    if (tooltipAndLabel.isEmpty) {
      message = annotations.join('; ');
    } else {
      final String effectiveLabel;
      if (data.textDirection == null) {
        effectiveLabel = '${Unicode.FSI}$tooltipAndLabel${Unicode.PDI}';
        annotations.insert(0, 'MISSING TEXT DIRECTION');
      } else {
        effectiveLabel = switch (data.textDirection!) {
          TextDirection.rtl => '${Unicode.RLI}$tooltipAndLabel${Unicode.PDI}',
          TextDirection.ltr => tooltipAndLabel,
        };
      }
      if (annotations.isEmpty) {
        message = effectiveLabel;
      } else {
        message = '$effectiveLabel (${annotations.join('; ')})';
      }
    }

    return message.trim();
  }

  void _paintMessage(Canvas canvas, SemanticsNode node) {
    final message = getMessage(node);
    if (message.isEmpty) {
      return;
    }
    final rect = node.rect;
    canvas.save();
    canvas.clipRect(rect);
    final textPainter =
        TextPainter()
          ..text = TextSpan(style: labelStyle, text: message)
          ..textDirection =
              TextDirection
                  .ltr // _getMessage always returns LTR text, even if node.label is RTL
          ..textAlign = TextAlign.center
          ..layout(maxWidth: rect.width);

    textPainter.paint(
      canvas,
      Alignment.center.inscribe(textPainter.size, rect).topLeft,
    );

    textPainter.dispose();
    canvas.restore();
  }

  int _findDepth(SemanticsNode node) {
    if (!node.hasChildren || node.mergeAllDescendantsIntoThisNode) {
      return 1;
    }
    var childrenDepth = 0;
    node.visitChildren((child) {
      childrenDepth = math.max(childrenDepth, _findDepth(child));
      return true;
    });
    return childrenDepth + 1;
  }

  void _paint(
    Canvas canvas,
    SemanticsNode node,
    int rank,
    int indexInParent,
    int level,
  ) {
    canvas.save();
    if (node.transform != null) {
      canvas.transform(node.transform!.storage);
    }
    final rect = node.rect;
    if (!rect.isEmpty) {
      final lineColor = _colorForNode(indexInParent, level);
      final innerRect = rect.deflate(rank * 1.0);
      if (innerRect.isEmpty) {
        final fill =
            Paint()
              ..color = lineColor
              ..style = PaintingStyle.fill;
        canvas.drawRect(rect, fill);
      } else {
        final fill =
            Paint()
              ..color = const Color(0xFFFFFFFF)
              ..style = PaintingStyle.fill;
        canvas.drawRect(rect, fill);
        final line =
            Paint()
              ..strokeWidth = rank * 2.0
              ..color = lineColor
              ..style = PaintingStyle.stroke;
        canvas.drawRect(innerRect, line);
      }
      _paintMessage(canvas, node);
    }
    if (!node.mergeAllDescendantsIntoThisNode) {
      final childRank = rank - 1;
      final childLevel = level + 1;
      var childIndex = 0;
      node.visitChildren((child) {
        _paint(canvas, child, childRank, childIndex, childLevel);
        childIndex += 1;
        return true;
      });
    }
    canvas.restore();
  }

  static Color _colorForNode(int index, int level) {
    return HSLColor.fromAHSL(
      1.0,
      // Use custom hash to ensure stable value regardless of Dart changes
      360.0 * math.Random(_getColorSeed(index, level)).nextDouble(),
      1.0,
      0.7,
    ).toColor();
  }

  static int _getColorSeed(int level, int index) {
    // Should be no collision as long as children number < 10000.
    return level * 10000 + index;
  }
}
