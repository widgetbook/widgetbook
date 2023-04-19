import 'package:flutter/material.dart';

import 'widgetbook_addon_model.dart';
import 'widgetbook_addon_scope.dart';

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
    required this.name,
    required this.setting,
  }) : notifier = ValueNotifier<T>(setting);

  final String name;
  final T setting;
  late ValueNotifier<T> notifier;

  T get value => notifier.value;

  void addListener(ValueChanged<T> listener) {
    notifier.addListener(
      () => listener(notifier.value),
    );
  }

  void onChanged(T value) {
    notifier.value = value;
  }

  WidgetbookAddonScope<T> buildWithScope(
    Map<String, String> queryParameters,
    Widget child,
  ) {
    onChanged(
      setting.fromQueryParameter(queryParameters) ?? setting,
    );

    return WidgetbookAddonScope<T>(
      key: ValueKey(notifier.value),
      notifier: notifier,
      child: child,
    );
  }

  Widget build(
    BuildContext context,
  );
}

extension AddonExtension on BuildContext {
  T? getAddonValue<T extends WidgetbookAddOnModel<T>>() {
    return WidgetbookAddonScope.of<T>(this) as T?;
  }
}
