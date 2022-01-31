import 'package:flutter/material.dart';
import 'package:widgetbook/src/localization/localization_state.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

class LocalizationProvider extends StateChangeNotifier<LocalizationState> {
  LocalizationProvider({
    List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  }) : super(
          state: LocalizationState(
            localizationsDelegates: localizationsDelegates,
          ),
        );
}
