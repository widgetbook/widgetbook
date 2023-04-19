import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
abstract class WidgetbookAddOn<T extends WidgetbookAddOnModel> {
  WidgetbookAddOn({
    required this.name,
    required this.setting,
  }) : provider = ValueNotifier<T>(setting);

  final String name;
  final T setting;
  late ValueNotifier<T> provider;

  T get value => provider.value;

  void addListener(ValueChanged<T> listener) {
    provider.addListener(
      () => listener(provider.value),
    );
  }

  void onChanged(T value) {
    provider.value = value;
  }

  Widget buildProvider(
    Map<String, String> queryParameters,
    Widget child,
  ) {
    final newSetting = setting.fromQueryParameter(queryParameters) ?? setting;

    provider.value = newSetting;

    return ChangeNotifierProvider.value(
      key: ValueKey(newSetting),
      value: provider,
      child: child,
    );
  }

  Widget build(
    BuildContext context,
  );
}

extension AddonExtension on BuildContext {
  T? getAddonValue<T extends WidgetbookAddOnModel>() {
    return read<ValueNotifier<T>?>()?.value;
  }
}
