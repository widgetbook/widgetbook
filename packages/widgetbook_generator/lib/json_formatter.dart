import 'dart:convert';

import 'package:widgetbook_generator/models/widgetbook_data.dart';
import 'package:widgetbook_generator/models/widgetbook_device_data.dart';
import 'package:widgetbook_generator/models/widgetbook_text_scale_factor_data.dart';

extension JsonListExtension on List<WidgetbookData> {
  String toJson() => const JsonEncoder.withIndent('  ')
      .convert(map((data) => data.toJson()).toList());
}

extension JsonListDeviceExtension on List<WidgetbookDeviceData> {
  String toJson() => const JsonEncoder.withIndent('  ')
      .convert(map((data) => data.toJson()).toList());
}

extension JsonListTextScaleFactorExtension
    on List<WidgetbookTextScaleFactorData> {
  String toJson() => const JsonEncoder.withIndent('  ')
      .convert(map((data) => data.toJson()).toList());
}
