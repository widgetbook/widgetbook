import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:widgetbook/src/addons/models/panel_size.dart';

class WidgetbookAddOn {
  const WidgetbookAddOn({
    required this.icon,
    required this.name,
    // TODO This can be optional/nullable
    required this.wrapperBuilder,
    required this.builder,
    required this.providerBuilder,
    required this.getQueryParameter,
    this.panelSize = PanelSize.small,
  });

  // TODO if we make this a builder, we can access buildcontext
  final Widget icon;

  final String name;

  final PanelSize panelSize;

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
}
