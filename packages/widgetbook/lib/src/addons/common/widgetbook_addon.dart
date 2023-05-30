import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../fields/fields.dart';
import '../../knobs/knobs.dart';
import '../../models/models.dart';
import '../addons.dart';

/// [WidgetbookAddOn]s are like global [Knob]s, they change the state for all
/// [WidgetbookUseCase]s. For example, you can manipulate the theme for all
/// [WidgetbookUseCase]s, instead of doing it one-by-one using [Knob]s.
///
/// See also:
///
/// * [ThemeAddon], changes the active custom theme.
/// * [MaterialThemeAddon], changes the active [ThemeData].
/// * [CupertinoThemeAddon], changes the active [CupertinoThemeData].
/// * [TextScaleAddon], changes the active [MediaQueryData.textScaleFactor].
/// * [LocalizationAddon], changes the active [Locale].
/// * [DeviceFrameAddon], an [WidgetbookAddOn] to change the active frame that
///   allows to view the [WidgetbookUseCase] on different screens.
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

  /// Converts the [fields] into a [Widget] by calling their [Field.build] and
  /// grouping them inside a [Column].
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
