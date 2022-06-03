import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_localizations_delegates_data.freezed.dart';
part 'widgetbook_localizations_delegates_data.g.dart';

@freezed
class WidgetbookLocalizationsDelegatesData
    with _$WidgetbookLocalizationsDelegatesData {
  factory WidgetbookLocalizationsDelegatesData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookLocalizationsDelegatesData;

  factory WidgetbookLocalizationsDelegatesData.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WidgetbookLocalizationsDelegatesDataFromJson(json);
}
