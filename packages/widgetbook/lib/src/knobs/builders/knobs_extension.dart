import 'package:flutter/widgets.dart';

import '../../state/state.dart';
import 'knobs_builder.dart';

extension KnobsExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  KnobsBuilder get knobs {
    final state = WidgetbookState.of(this);
    return KnobsBuilder(state.registerKnob);
  }
}
