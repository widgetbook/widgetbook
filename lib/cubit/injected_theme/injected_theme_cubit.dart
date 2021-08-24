import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'injected_theme_state.dart';

class InjectedThemeCubit extends Cubit<InjectedThemeState> {
  InjectedThemeCubit({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) : super(
          InjectedThemeState(
            lightTheme: lightTheme,
            darkTheme: darkTheme,
          ),
        );

  void themesChanged({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) {
    emit(
      InjectedThemeState(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
