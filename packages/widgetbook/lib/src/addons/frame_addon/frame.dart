import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/addons/addon.dart';

abstract class Frame {
  Frame({
    required this.name,
    required this.addon,
  });

  final String name;

  WidgetbookAddOn addon;
  Widget builder(BuildContext context, Widget child);
}
