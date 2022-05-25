import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_app_builder_data.freezed.dart';
part 'widgetbook_app_builder_data.g.dart';

@freezed
class WidgetbookAppBuilderData extends WidgetbookData
    with _$WidgetbookAppBuilderData {
  factory WidgetbookAppBuilderData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookAppBuilderData;

  factory WidgetbookAppBuilderData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookAppBuilderDataFromJson(json);
}
