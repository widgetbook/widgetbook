import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class WidgetbookAddOn {
  const WidgetbookAddOn({
    required this.name,
    required this.wrapperBuilder,
    required this.builder,
    required this.providerBuilder,
    required this.getQueryParameter,
  });

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
  ) providerBuilder;

  final Map<String, String> Function(BuildContext context) getQueryParameter;

  @override
  bool operator ==(Object other) =>
      other is WidgetbookAddOn && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
