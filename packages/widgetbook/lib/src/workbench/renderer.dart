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

  Widget _buildPreview(
    BuildContext context, {
    required List<WidgetbookAddOn> addons,
  }) {
    return Builder(
      builder: (context) {
        return appBuilder(
          context,
          Builder(
            key: const Key('app_builder_key'),
            builder: useCaseBuilder,
          ),
        );
      },
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
