import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/custom_addon/custom_addon_setting.dart';

class CustomAddonSelectionProvider<T>
    extends ValueNotifier<CustomAddonSetting<T>> {
  CustomAddonSelectionProvider(
    super.data,
  );

  void tapped(T data) {
    final currentSelection = Set<T>.from(value.activeData);
    if (currentSelection.contains(data)) {
      currentSelection.remove(data);
    } else {
      currentSelection.add(data);
    }

    value = value.copyWith(activeData: currentSelection);
  }
}
