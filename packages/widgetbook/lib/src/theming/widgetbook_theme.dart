import 'package:freezed_annotation/freezed_annotation.dart';

part 'widgetbook_theme.freezed.dart';

@freezed
class WidgetbookTheme<CustomTheme> with _$WidgetbookTheme<CustomTheme> {
  factory WidgetbookTheme({
    required String name,
    required CustomTheme data,
  }) = _WidgetbookTheme;
}
