import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_theme_data.freezed.dart';
part 'widgetbook_theme_data.g.dart';

@freezed
class WidgetbookThemeData with _$WidgetbookThemeData {
  factory WidgetbookThemeData({
    // The property or method name defining the theme
    required String name,
    required String importStatement,
    required List<String> dependencies,
    required bool isDefault,
    // The name of the theme shown in Widgetbook
    // Also the string used in Widgetbook URL to set the property selection.
    required String themeName,
  }) = _WidgetbookThemeData;

  factory WidgetbookThemeData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookThemeDataFromJson(json);
}
