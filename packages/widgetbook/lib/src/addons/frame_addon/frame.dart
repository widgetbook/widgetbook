import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/addons/addon.dart';

@immutable
abstract class Frame {
  const Frame({
    required this.name,
    required this.addon,
  });

  final String name;
  final WidgetbookAddOn addon;

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
