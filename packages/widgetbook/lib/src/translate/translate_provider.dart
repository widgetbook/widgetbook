import 'package:flutter/material.dart';
import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/src/translate/translate_state.dart';

class TranslateProvider extends StateChangeNotifier<TranslateState> {
  TranslateProvider({
    TranslateState? state,
  }) : super(
          state: state ?? TranslateState(),
        );

  void updateOffset(Offset offset) {
    state = TranslateState(offset: offset);
  }

  void updateRelativeOffset(Offset offset) {
    state = state.copyWith(
      offset: state.offset + offset,
    );
  }

  void resetOffset() {
    state = TranslateState();
  }
}
