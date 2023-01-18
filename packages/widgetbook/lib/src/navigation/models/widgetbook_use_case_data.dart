import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'widgetbook_use_case_data.freezed.dart';

@freezed
class WidgetbookUseCaseData with _$WidgetbookUseCaseData {
  const factory WidgetbookUseCaseData({
    required String path,
    required UseCaseBuilder builder,
  }) = _WidgetbookUseCaseData;
}
