import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';

class Renderer extends StatelessWidget {
  const Renderer({
    super.key,
    required this.useCaseBuilder,
    required this.appBuilder,
  });

  final Widget Function(BuildContext) useCaseBuilder;
  final Widget Function(BuildContext, Widget child) appBuilder;

  Widget _buildPreview(
    BuildContext context, {
    required List<WidgetbookAddOn> addons,
  }) {
    return MultiProvider(
      key: ValueKey(useCaseBuilder),
      providers: addons.map((e) => e.providerBuilder(context)).toList(),
      child: Builder(
        builder: (context) {
          return appBuilder(
            context,
            Builder(
              key: const Key('app_builder_key'),
              builder: useCaseBuilder,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final addons = context.watch<AddOnProvider>().value;

    return _buildPreview(
      context,
      addons: addons,
    );
  }
}
