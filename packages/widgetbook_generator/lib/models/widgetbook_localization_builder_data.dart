import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_localization_builder_data.freezed.dart';
part 'widgetbook_localization_builder_data.g.dart';

@freezed
class WidgetbookLocalizationBuilderData extends WidgetbookData
    with _$WidgetbookLocalizationBuilderData {
  factory WidgetbookLocalizationBuilderData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookLocalizationBuilderData;

  factory WidgetbookLocalizationBuilderData.fromJson(
          Map<String, dynamic> json) =>
      _$WidgetbookLocalizationBuilderDataFromJson(json);
}
