import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_use_case_builder_data.freezed.dart';
part 'widgetbook_use_case_builder_data.g.dart';

@freezed
class WidgetbookUseCaseBuilderData extends WidgetbookData
    with _$WidgetbookUseCaseBuilderData {
  factory WidgetbookUseCaseBuilderData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookUseCaseBuilderData;

  factory WidgetbookUseCaseBuilderData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookUseCaseBuilderDataFromJson(json);
}
