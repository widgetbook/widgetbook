import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_addon_data.freezed.dart';
part 'widgetbook_addon_data.g.dart';

@freezed
class WidgetbookAddonData with _$WidgetbookAddonData {
  factory WidgetbookAddonData({
    /// The (type) name of the annotated element
    required String name,

    /// The name of the setting variable
    required String variableName,
    required String importStatement,
  }) = _WidgetbookAddonData;

  factory WidgetbookAddonData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookAddonDataFromJson(json);
}
