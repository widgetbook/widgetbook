import 'package:flutter/material.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

class Preview extends StatelessWidget {
  const Preview({
    Key? key,
    required this.useCase,
    required this.appBuilder,
  }) : super(key: key);

  final WidgetbookUseCase useCase;
  final Widget Function(BuildContext, Widget child) appBuilder;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Renderer(
        appBuilder: appBuilder,
        useCaseBuilder: useCase.builder,
      ),
    );
  }
}
