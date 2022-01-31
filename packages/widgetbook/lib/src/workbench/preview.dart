import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ClipRect(
      child: OverflowBox(
        child: Transform.scale(
            scale: context.watch<ZoomProvider>().state.zoomLevel,
            child: ComparisonRenderer<CustomTheme>()),
      ),
    );
  }
}
