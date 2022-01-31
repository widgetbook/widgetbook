import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/theming/theming_state.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';

late Object _provider;

StateNotifierProvider<Theming<CustomTheme>, ThemingState<CustomTheme>>
    getProvider<CustomTheme>() {
  return _provider
      as StateNotifierProvider<Theming<CustomTheme>, ThemingState<CustomTheme>>;
}

void initializeProvider<CustomTheme>() {
  _provider =
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
