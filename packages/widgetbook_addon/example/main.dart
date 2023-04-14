import 'package:flutter/material.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

class CustomAddOnSetting extends WidgetbookAddOnModel {
  const CustomAddOnSetting({
    required this.data,
  });

  final String data;

  @override
  Map<String, String> toQueryParameter() {
    return {
      'data': data,
    };
  }
}

class CustomAddOn extends WidgetbookAddOn<CustomAddOnSetting> {
  CustomAddOn({
    required super.setting,
  }) : super(
          name: 'Custom',
        );

  @override
  Widget build(BuildContext context) {
    return Text(value.data);
  }

  @override
  void updateQueryParameters(BuildContext context, CustomAddOnSetting value) {
    context.goTo(
      queryParams: value.toQueryParameter(),
    );
  }

  @override
  CustomAddOnSetting settingFromQueryParameters({
    required Map<String, String> queryParameters,
    required CustomAddOnSetting setting,
  }) {
    return CustomAddOnSetting(
      data: queryParameters['data'] ?? 'Unknown',
    );
  }
}

/// Allows accessing addons from [context]
extension CustomAddOnExtension on BuildContext {
  CustomAddOnSetting? get custom => getAddonValue<CustomAddOnSetting>();
}
