import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/addons/addon.dart';

abstract class Frame {
  Frame({
    required this.name,
    required this.addon,
    required this.getDefaultQueryParameters,
  });

  final String name;

  WidgetbookAddOn addon;
  Map<String, String> getDefaultQueryParameters;
  Widget builder(BuildContext context, Widget child);
}
