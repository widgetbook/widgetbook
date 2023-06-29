/// A custom addon example for Widgetbook
///
/// [Ref link]: https://docs.widgetbook.io/addons/custom-addon
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class AdvancedCustomAddonValue {
  AdvancedCustomAddonValue({
    required this.stringValue,
    required this.doubleValue,
    required this.boolValue,
  });

  final String stringValue;
  final double doubleValue;
  final bool boolValue;
}

class AdvancedCustomAddon extends WidgetbookAddon<AdvancedCustomAddonValue> {
  AdvancedCustomAddon({
    required this.initialValue,
  }) : super(
          name: 'Custom Addon',
          initialSetting: initialValue,
        );

  final AdvancedCustomAddonValue initialValue;

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    AdvancedCustomAddonValue setting,
  ) {
    // Return a widget that uses the setting to modify the child widget.
    return Container();
  }

  @override
  List<Field> get fields {
    return [
      StringField(
        name: 'stringField',
        initialValue: initialValue.stringValue,
      ),
      DoubleInputField(
        name: 'doubleInputField',
        initialValue: initialValue.doubleValue,
      ),
      BooleanField(
        name: 'booleanField',
        initialValue: initialValue.boolValue,
      ),
    ];
  }

  @override
  AdvancedCustomAddonValue valueFromQueryGroup(Map<String, String> group) {
    final stringValue = valueOf<String>('stringField', group);
    final doubleValue = valueOf<double>('doubleInputField', group);
    final boolValue = valueOf<bool>('booleanField', group);

    return AdvancedCustomAddonValue(
      stringValue: stringValue ?? initialValue.stringValue,
      doubleValue: doubleValue ?? initialValue.doubleValue,
      boolValue: boolValue ?? initialSetting.boolValue,
    );
  }
}
