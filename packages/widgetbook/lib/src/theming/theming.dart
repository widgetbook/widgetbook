import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/theming/theming_state.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';

final themingProvider = StateNotifierProvider<Theming, ThemingState>(
  (ref) {
    return Theming();
  },
);

class Theming extends StateNotifier<ThemingState> {
  Theming()
      : super(
          ThemingState(),
        );

  void hotReloadUpdate({
    required List<WidgetbookTheme> themes,
  }) {
    state = state.copyWith(themes: themes);
  }
}
