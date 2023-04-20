import 'package:flutter/material.dart';

import 'widgetbook_addon_model.dart';

class WidgetbookAddonScope<T extends WidgetbookAddOnModel<T>>
    extends InheritedNotifier<ValueNotifier<WidgetbookAddOnModel<T>>> {
  WidgetbookAddonScope({
    super.key,
    super.notifier,
    required super.child,
  });

  static WidgetbookAddOnModel<T>? of<T extends WidgetbookAddOnModel<T>>(
    BuildContext context,
  ) {
    return context
        .dependOnInheritedWidgetOfExactType<WidgetbookAddonScope<T>>()
        ?.notifier
        ?.value;
  }
}
