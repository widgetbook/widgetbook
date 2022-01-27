import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';

part 'theming_state.freezed.dart';

@freezed
class ThemingState<T> with _$ThemingState<T> {
  factory ThemingState({
    required List<WidgetbookTheme<T>> themes,
  }) = _ThemingState<T>;
}
