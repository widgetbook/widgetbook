import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/mouse_tool/tool_provider.dart';
import 'package:widgetbook/src/mouse_tool/tool_state.dart';
import 'package:widgetbook/src/translate/translate_provider.dart';
import 'package:widgetbook/src/workbench/comparison_renderer.dart';
import 'package:widgetbook/src/zoom/zoom_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class Preview<CustomTheme> extends StatelessWidget {
  const Preview({
    Key? key,
    required this.useCase,
  }) : super(key: key);

  final WidgetbookUseCase useCase;

  @override
  Widget build(BuildContext context) {
    final toolState = context.watch<ToolProvider>().state;
    final isMoveState = toolState.mode == SelectionMode.move;
    return MouseRegion(
      cursor: isMoveState ? SystemMouseCursors.move : MouseCursor.defer,
      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent && isMoveState) {
            context.read<ZoomProvider>().zoomRelative(
                  event.scrollDelta.dy / 200,
                );
          }
        },
        onPointerMove: (e) {
          if (e.down && isMoveState) {
            context.read<TranslateProvider>().updateRelativeOffset(e.delta);
          }
        },
        child: ClipRect(
          child: OverflowBox(
            maxHeight: double.maxFinite,
            maxWidth: double.maxFinite,
            child: Transform.scale(
              scale: context.watch<ZoomProvider>().state.zoomLevel,
              child: Transform.translate(
                offset: context.watch<TranslateProvider>().state.offset,
                child: ComparisonRenderer<CustomTheme>(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
