import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_theme_builder_data.freezed.dart';
part 'widgetbook_theme_builder_data.g.dart';

@freezed
class WidgetbookThemeBuilderData extends WidgetbookData
    with _$WidgetbookThemeBuilderData {
  factory WidgetbookThemeBuilderData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookThemeBuilderData;

  factory WidgetbookThemeBuilderData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookThemeBuilderDataFromJson(json);
}
