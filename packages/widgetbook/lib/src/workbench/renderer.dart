import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/widgetbook.dart';

class Renderer extends StatelessWidget {
  const Renderer({
    required this.useCaseBuilder,
    required this.appBuilder,
    super.key,
  });

  final Widget Function(BuildContext) useCaseBuilder;
  final Widget Function(BuildContext, Widget child) appBuilder;

  @override
  Widget build(BuildContext context) {
    final addons = context.watch<AddOnProvider>().value;

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
