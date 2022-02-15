import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_theme_type_data.freezed.dart';
part 'widgetbook_theme_type_data.g.dart';

@freezed
class WidgetbookThemeTypeData extends WidgetbookData
    with _$WidgetbookThemeTypeData {
  factory WidgetbookThemeTypeData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookThemeTypeData;

  factory WidgetbookThemeTypeData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookThemeTypeDataFromJson(json);
}
