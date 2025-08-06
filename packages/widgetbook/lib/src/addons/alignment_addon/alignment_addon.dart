import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for testing widget alignment within its container.
///
/// The alignment addon wraps use cases with an [Align] widget, allowing
/// developers to test how their widgets behave when positioned at different
/// locations within their parent container.
///
/// Learn more: https://docs.widgetbook.io/addons/alignment-addon
class AlignmentAddon extends WidgetbookAddon<Alignment> {
  /// Creates a new instance of [AlignmentAddon].
  AlignmentAddon({
    this.initialAlignment = Alignment.center,
  }) : super(
         name: 'Alignment',
       );

  /// The default alignment applied when the addon first loads.
  ///
  /// This value is used as the initial selection in the alignment dropdown
  /// and determines the starting position of the wrapped widget.
  ///
  /// Defaults to [Alignment.center] for centered positioning.
  final Alignment initialAlignment;

  /// Maps [Alignment] values to their human-readable string representations.
  ///
  /// Used for both URL query parameters and dropdown labels in the UI.
  /// Contains all nine standard alignment positions in a 3x3 grid layout.
  static final alignments = {
    Alignment.topLeft: 'Top Left',
    Alignment.topCenter: 'Top Center',
    Alignment.topRight: 'Top Right',
    Alignment.centerLeft: 'Center Left',
    Alignment.center: 'Center',
    Alignment.centerRight: 'Center Right',
    Alignment.bottomLeft: 'Bottom Left',
    Alignment.bottomCenter: 'Bottom Center',
    Alignment.bottomRight: 'Bottom Right',
  };

  @override
  List<Field<Alignment>> get fields {
    return [
      ObjectDropdownField<Alignment>(
        name: 'alignment',
        initialValue: initialAlignment,
        values: alignments.keys.toList(),
        labelBuilder: (value) => alignments[value]!,
      ),
    ];
  }

  @override
  Alignment valueFromQueryGroup(Map<String, String> group) {
    return valueOf<Alignment>('alignment', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    Alignment setting,
  ) {
    return Align(
      alignment: setting,
      child: child,
    );
  }
}
