import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

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
        builder: (context, addon, child) => addon.buildUseCaseWrapper(
          context,
          child,
        ),
        child: Scaffold(
          body: useCaseBuilder(context),
        ),
      ),
    );
  }
}
