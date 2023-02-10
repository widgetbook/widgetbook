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

  @override
  bool operator ==(Object other) =>
      other is Frame && name == other.name && addon == other.addon;

  @override
  int get hashCode => Object.hash(
        name,
        addon,
      );
}
