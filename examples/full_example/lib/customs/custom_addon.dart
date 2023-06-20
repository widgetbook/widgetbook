/// A custom addon example for Widgetbook
///
/// [Ref link]: https://docs.widgetbook.io/addons/custom-addon
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class CustomAddon extends WidgetbookAddon<String> {
  CustomAddon({
    required this.customValue,
    String? initialCustomValue,
    int? this.maxLines,
  }) : super(
          name: 'Your Custom Addon Name',
          initialSetting: initialCustomValue ?? customValue,
        );

  final String customValue;
  final int? maxLines;

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    String setting,
  ) {
    // customize how the use case is built using your custom Addon
    return Container();
  }

  @override
  List<Field> get fields {
    return [
      StringField(
        group: slugName,
        name: 'yourCustomName',
        maxLines: maxLines,
        initialValue: initialSetting,
      )
    ];
  }

  @override
  String valueFromQueryGroup(Map<String, String> group) {
    final value = valueOf<String>('yourCustomName', group);
    return value ?? initialSetting;
  }
}
