import 'package:flutter/material.dart';
import 'package:widgetbook/src/state/state.dart';
import 'package:widgetbook/widgetbook.dart';

class Renderer extends StatelessWidget {
  const Renderer({
    super.key,
    required this.useCaseBuilder,
    required this.appBuilder,
  });

  final Widget Function(BuildContext) useCaseBuilder;
  final Widget Function(BuildContext, Widget child) appBuilder;

  @override
  Widget build(BuildContext context) {
    final addons = WidgetbookState.of(context).addons;

    return appBuilder(
      context,
      MultiAddonBuilder(
        addons: addons,
        builder: (context, addon, child) {
          return addon.buildUseCase(
            context,
            child,
          );
        },
        child: Scaffold(
          body: useCaseBuilder(context),
        ),
      ),
    );
  }
}
