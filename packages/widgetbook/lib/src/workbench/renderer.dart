import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/routing/router.dart';
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
    final queryParams = GoRouterState.of(context).queryParams;

    return appBuilder(
      context,
      MultiAddonBuilder(
        addons: addons,
        onChanged: (setting) => context.goTo(
          queryParams: setting.toQueryParameter(),
        ),
        builder: (context, addon, child) {
          return addon.buildUseCase(
            context,
            addon.setting.fromQueryParameter(queryParams) ?? addon.setting,
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
