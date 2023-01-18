import 'package:flutter/material.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

class Preview extends StatelessWidget {
  const Preview({
    super.key,
    required this.useCaseBuilder,
    required this.appBuilder,
  });

  final UseCaseBuilder useCaseBuilder;
  final Widget Function(BuildContext, Widget child) appBuilder;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Renderer(
        appBuilder: appBuilder,
        useCaseBuilder: useCaseBuilder,
      ),
    );
  }
}
