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
/// * [FrameAddon], an [WidgetbookAddOn] to change the active [Frame] that
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

  /// Allows for parsing of [queryParameters] by using information from the
  /// router and from the initially provided [setting].
  ///
  /// If no [queryParameters] are available, return [setting].
  /// If [queryParameters] are avaialbe return a propert `Setting` object.
  ///
  /// If not overriden, returns the initially provided [setting].
  T settingFromQueryParameters({
    required Map<String, String> queryParameters,
    required T setting,
  }) {
    return setting;
  }

  T get value => provider.value;

  void addListener(ValueChanged<T> listener) {
    provider.addListener(
      () => listener(provider.value),
    );
  }

  void onChanged(BuildContext context, T value) {
    provider.value = value;
  }

  Widget buildProvider(
    BuildContext context,
    Map<String, String> queryParameters,
    Widget child,
  ) {
    provider.value = settingFromQueryParameters(
      queryParameters: queryParameters,
      setting: setting,
    );

    return ChangeNotifierProvider.value(
      key: ValueKey(provider.value),
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
