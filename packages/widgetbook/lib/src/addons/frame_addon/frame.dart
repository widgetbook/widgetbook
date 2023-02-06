import 'package:collection/collection.dart';
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

  @override
  bool operator ==(Object other) =>
      other is Frame &&
      name == other.name &&
      addon == other.addon &&
      const MapEquality<String, String>().equals(
        getDefaultQueryParameters,
        other.getDefaultQueryParameters,
      );

  @override
  int get hashCode => Object.hash(
        name,
        addon,
        getDefaultQueryParameters,
      );
}
