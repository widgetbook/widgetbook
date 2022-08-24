import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class WidgetbookAddOn {
  const WidgetbookAddOn({
    required this.icon,
    required this.name,
    // TODO This can be optional/nullable
    required this.wrapperBuilder,
    required this.builder,
    required this.providerBuilder,
    required this.selectionCount,
    required this.getQueryParameter,
  });

  // TODO if we make this a builder, we can access buildcontext
  final Widget icon;

  final String name;

  final Widget Function(
    BuildContext context,
    Map<String, dynamic> routerData,
    Widget child,
  ) wrapperBuilder;

  final Widget Function(
    BuildContext context,
  ) builder;

  final SingleChildWidget Function(
    BuildContext context,
    int index,
  ) providerBuilder;

  final int Function(BuildContext context) selectionCount;

  final String Function(BuildContext context) getQueryParameter;
}
