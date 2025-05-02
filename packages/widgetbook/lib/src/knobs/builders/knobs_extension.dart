import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import '../../state/state.dart';
import '../knob.dart';
import 'knobs_builder.dart';

extension KnobsExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  KnobsBuilder get knobs {
    // Use InheritedWidgetbookState.of instead of WidgetbookState.of to ensure
    // knobs work correctly even when nested in a Navigator (like with DeviceFrameAddon)
    final state = InheritedWidgetbookState.of(this);
    final queryGroup = FieldCodec.decodeQueryGroup(
      state.queryParams['knobs'],
    );

    T? register<T>(Knob<T?> knob) {
      return state.knobs.register(
        knob,
        queryGroup,
      );
    }

    return KnobsBuilder(register);
  }
}
