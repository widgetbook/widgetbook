import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/theming/theming_state.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';

late Object _themingProvider;

StateNotifierProvider<Theming<CustomTheme>, ThemingState<CustomTheme>>
    getThemingProvider<CustomTheme>() {
  return _themingProvider
      as StateNotifierProvider<Theming<CustomTheme>, ThemingState<CustomTheme>>;
}

void initializeThemingProvider<CustomTheme>() {
  _themingProvider =
      StateNotifierProvider<Theming<CustomTheme>, ThemingState<CustomTheme>>(
    (ref) {
      return Theming<CustomTheme>();
    },
  );
}

// TODO remove if this is working
// final themingProvider = StateNotifierProvider<Theming, ThemingState>(
//   (ref) {
//     return Theming<CustomTheme>();
//   },
// );

class Theming<CustomTheme> extends StateNotifier<ThemingState<CustomTheme>> {
  Theming()
      : super(
          ThemingState<CustomTheme>(
            themes: [],
          ),
        );

  void hotReloadUpdate({
    required List<WidgetbookTheme<CustomTheme>> themes,
  }) {
    state = state.copyWith(themes: themes);
  }
}
