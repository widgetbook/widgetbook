import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import '../../state/state.dart';
import '../knob.dart';
import 'knobs_builder.dart';

/// Extension on [BuildContext] that provides access to knobs functionality.
///
/// This extension allows use cases to access knobs through the `context.knobs`
/// property, providing a convenient API for creating interactive controls.
extension KnobsExtension on BuildContext {
  /// Creates adjustable parameters for the current [WidgetbookUseCase].
  ///
  /// Returns a [KnobsBuilder] that provides methods for creating different
  /// types of knobs (string, boolean, color, etc.). The knobs are automatically
  /// registered with the Widgetbook state and their values are synchronized
  /// with URL query parameters.
  ///
  /// Example usage:
  /// ```dart
  /// WidgetbookUseCase(
  ///   name: 'Interactive Example',
  ///   builder: (context) {
  ///     final title = context.knobs.string(
  ///       label: 'Title',
  ///       initialValue: 'Hello World',
  ///     );
  ///     final count = context.knobs.int.slider(
  ///       label: 'Count',
  ///       initialValue: 5,
  ///       min: 0,
  ///       max: 10,
  ///     );
  ///     final isVisible = context.knobs.boolean(
  ///       label: 'Visible',
  ///       initialValue: true,
  ///     );
  ///
  ///     return Visibility(
  ///       visible: isVisible,
  ///       child: Column(
  ///         children: [
  ///           Text(title),
  ///           for (int i = 0; i < count; i++)
  ///             Text('Item $i'),
  ///         ],
  ///       ),
  ///     );
  ///   },
  /// )
  /// ```
  KnobsBuilder get knobs {
    final state = WidgetbookState.of(this);
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
