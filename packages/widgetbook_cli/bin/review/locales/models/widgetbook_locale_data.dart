import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_locale_data.freezed.dart';
part 'widgetbook_locale_data.g.dart';

@freezed
class WidgetbookLocaleData with _$WidgetbookLocaleData {
  factory WidgetbookLocaleData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
    required List<String> locales,
  }) = _WidgetbookLocaleData;

  factory WidgetbookLocaleData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookLocaleDataFromJson(json);
}
