import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';

part 'theming_state.freezed.dart';

@freezed
class ThemingState with _$ThemingState {
  factory ThemingState({
    @Default(<WidgetbookTheme>[]) List<WidgetbookTheme> themes,
  }) = _ThemingState;
}
