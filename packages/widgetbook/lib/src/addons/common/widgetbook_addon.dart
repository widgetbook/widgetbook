import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../../knobs/knobs.dart';
import '../../navigation/navigation.dart';
import '../../settings/settings.dart';
import '../addons.dart';

/// [WidgetbookAddon]s are like global [Knob]s, they change the state for all
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
/// * [DeviceFrameAddon], an [WidgetbookAddon] to change the active frame that
///   allows to view the [WidgetbookUseCase] on different screens.
@optionalTypeArgs
abstract class WidgetbookAddon<T> extends FieldsComposable<T> {
  WidgetbookAddon({
    required this.name,
    required this.initialSetting,
  });

  final String name;
  final T initialSetting;

  String get slugName => name.trim().toLowerCase().replaceAll(RegExp(' '), '-');

  @override
  Widget buildFields(BuildContext context) {
    return Setting(
      name: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map((field) => field.build(context)).toList(),
      ),
    );
  }

  /// Wraps use cases with a custom widget depending on the addon [setting]
  /// that is obtained from [valueFromQueryGroup].
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    T setting,
  ) {
    return child;
  }
}
