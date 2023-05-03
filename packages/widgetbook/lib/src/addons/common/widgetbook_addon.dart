import 'package:flutter/material.dart';
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
abstract class WidgetbookAddOn<T extends WidgetbookAddOnModel<T>> {
  WidgetbookAddOn({
    required this.name,
    required T initialSetting,
  }) : setting = initialSetting;

  final String name;
  T setting;
  ValueChanged<T>? _listener;

  String get slugName => name.trim().toLowerCase().replaceAll(RegExp(' '), '-');

  void setListener(ValueChanged<T> listener) {
    _listener = listener;
  }

  /// Updates [setting] with the [newSetting] and calls the listeners.
  void updateSetting(T newSetting) {
    setting = newSetting;
    _listener?.call(newSetting);
  }

  /// Updates [setting] from [queryParams] **without** calling any listeners.
  /// Used sync the [setting] with the current URI's [queryParams], in case
  /// it was changed from the URL bar and not from the settings panel.
  void updateFromQueryParameters(Map<String, String> queryParams) {
    if (!queryParams.containsKey(slugName) || queryParams[slugName]!.isEmpty)
      return;

    setting = setting.fromEncoded(
      queryParams[slugName]!,
    );
  }

  Widget buildSetting(BuildContext context);

  /// Wraps use cases with a custom widget depending on the addon [setting].
  Widget buildUseCase(BuildContext context, Widget child) {
    return child;
  }
}
