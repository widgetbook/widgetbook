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

  @override
  CustomAddOnSetting? fromQueryParameter(Map<String, String> queryParameters) {
    return queryParameters.containsKey('data')
        ? CustomAddOnSetting(data: queryParameters['data']!)
        : null;
  }
}

class CustomAddOn extends WidgetbookAddOn<CustomAddOnSetting> {
  CustomAddOn({
    required super.initialSetting,
  });

  @override
  Widget build(BuildContext context) {
    return Text(setting.data);
  }
}

/// Allows accessing addons from [context]
extension CustomAddOnExtension on BuildContext {
  CustomAddOnSetting? get custom => getAddonValue<CustomAddOnSetting>();
}
