import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/addon.dart';

class AddOnProvider extends ValueNotifier<List<WidgetbookAddOn>> {
  AddOnProvider(List<WidgetbookAddOn> value) : super(value);

  // TODO This solution is a bit hacky
  void update() {
    notifyListeners();
  }
}
