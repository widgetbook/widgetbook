import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

part 'widgetbook_scaffold_builder_data.freezed.dart';
part 'widgetbook_scaffold_builder_data.g.dart';

@freezed
class WidgetbookScaffoldBuilderData extends WidgetbookData
    with _$WidgetbookScaffoldBuilderData {
  factory WidgetbookScaffoldBuilderData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
  }) = _WidgetbookScaffoldBuilderData;

  factory WidgetbookScaffoldBuilderData.fromJson(Map<String, dynamic> json) =>
      _$WidgetbookScaffoldBuilderDataFromJson(json);
}
