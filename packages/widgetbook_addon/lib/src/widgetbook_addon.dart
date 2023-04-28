import 'package:flutter/material.dart';

import 'widgetbook_addon_model.dart';

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
abstract class WidgetbookAddOn<T extends WidgetbookAddOnModel<T>> {
  WidgetbookAddOn({
    required this.initialSetting,
  }) : notifier = ValueNotifier<T>(initialSetting);

  final T initialSetting;
  late ValueNotifier<T> notifier;

  T get setting => notifier.value;

  void addListener(ValueChanged<T> listener) {
    notifier.addListener(
      () => listener(notifier.value),
    );
  }

  void onChanged(T value) {
    notifier.value = value;
  }

  Widget buildSetting(BuildContext context);

  /// Wraps use cases with a custom widget depending on the addon [initialSetting].
  Widget buildUseCase(BuildContext context, T setting, Widget child) {
    return child;
  }
}
