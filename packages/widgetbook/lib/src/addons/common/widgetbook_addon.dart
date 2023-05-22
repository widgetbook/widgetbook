import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../fields/fields.dart';
import '../addons.dart';

/// A class that can be used to extend the selection of Widgetbook properties.
///
/// See also:
///
/// * [ThemeAddon], a generic implementation of a [WidgetbookAddOn].
/// * [MaterialThemeAddon], an [WidgetbookAddOn] to change the active
///   [ThemeData] of the [WidgetbookUseCase].
/// * [DeviceAddon], an [WidgetbookAddOn] to change the active [Device] that
///   allows to view the [WidgetbookUseCase] on different screens.
///
/// You must not have multiple [WidgetbookAddOn]s that are of the same generic
/// type
abstract class WidgetbookAddOn<T> {
  WidgetbookAddOn({
    required this.name,
    required T initialSetting,
  }) : setting = initialSetting;

  final String name;
  T setting;

  String get slugName => name.trim().toLowerCase().replaceAll(RegExp(' '), '-');

  /// Updates [setting] with the [newSetting] and calls the listeners.
  void updateSetting(T newSetting) {
    setting = newSetting;
  }

  List<Field> get fields;

  Widget buildSetting(BuildContext context) {
    return Setting(
      name: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map((field) => field.build(context)).toList(),
      ),
    );
  }

  /// Wraps use cases with a custom widget depending on the addon [setting].
  Widget buildUseCase(BuildContext context, Widget child) {
    return child;
  }
}
