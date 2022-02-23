import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_theme_data.freezed.dart';
part 'widgetbook_theme_data.g.dart';

@freezed
class WidgetbookThemeData extends WidgetbookData with _$WidgetbookThemeData {
  /// Creates a new instance of [WidgetbookThemeData]
  ///
  /// [name] is defined as the identifier of the annotated element
  /// [importStatement] is the statement required to include the annotated
  /// element in the Widgetbook
  /// [dependencies] are the import statements defined in the file in which the
  /// annotation is used
  /// [isDefault] specified whether the theme is the default
  /// [themeName] specifies the shown name in the widgetbook UI
  factory WidgetbookThemeData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
    required bool isDefault,
    required String themeName,
  }) = _WidgetbookThemeData;

  factory WidgetbookThemeData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookThemeDataFromJson(json);
}
