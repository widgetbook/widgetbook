import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/localization/localization_state.dart';

final localizationProvider =
    StateNotifierProvider<Localization, LocalizationState>(
  (ref) {
    return Localization();
  },
);

class Localization extends StateNotifier<LocalizationState> {
  Localization({
    LocalizationState? state,
  }) : super(
          state ??
              LocalizationState(
                // TODO defaulting to an empty list is sketchy
                supportedLocales: const <Locale>[],
              ),
        );

  void hotReloadUpdate({
    required List<Locale> supportedLocales,
    required List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  }) {
    state = LocalizationState(
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
    );
  }
}
