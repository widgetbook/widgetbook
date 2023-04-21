import 'package:flutter/material.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

class Preview extends StatelessWidget {
  const Preview({
    required this.useCaseBuilder,
    required this.appBuilder,
    super.key,
  });

  final UseCaseBuilder useCaseBuilder;
  final Widget Function(BuildContext, Widget child) appBuilder;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constrains) {
          // Sets safe boundaries for proper rendering inside them.
          // This is needed for widgets that depend on [MediaQuery],
          // for example: widgets from `flutter_screenutil` package.
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(
                constrains.maxWidth,
                constrains.maxHeight,
              ),
            ),
            child: Renderer(
              appBuilder: appBuilder,
              useCaseBuilder: useCaseBuilder,
            ),
          );
        },
      ),
    );
  }
}
