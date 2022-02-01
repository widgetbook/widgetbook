import 'package:flutter/material.dart';
import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/src/translate/translate_state.dart';

/// A provider handling [Offset] translation to a previewed device or
/// collection.
///
/// Allows the user to pan around and adjust the viewport in case the device is
/// not in focus.
class TranslateProvider extends StateChangeNotifier<TranslateState> {
  TranslateProvider({
    TranslateState? state,
  }) : super(
          state: state ?? TranslateState(),
        );

  /// Overrides the current [Offset] by the provided [offset].
  void updateOffset(Offset offset) {
    state = TranslateState(offset: offset);
  }

  /// Updates the current [Offset] by the provided [offset].
  void updateRelativeOffset(Offset offset) {
    state = state.copyWith(
      offset: state.offset + offset,
    );
  }

  /// Resets the [Offset] to [Offset.zero]
  void resetOffset() {
    state = TranslateState();
  }
}
