import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_locales_data.freezed.dart';
part 'widgetbook_locales_data.g.dart';

@freezed
class WidgetbookLocalesData extends WidgetbookData
    with _$WidgetbookLocalesData {
  factory WidgetbookLocalesData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
    required List<String> locales,
  }) = _WidgetbookLocalesData;

  factory WidgetbookLocalesData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookLocalesDataFromJson(json);
}
