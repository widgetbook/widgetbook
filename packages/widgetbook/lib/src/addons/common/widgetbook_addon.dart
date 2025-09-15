import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../../knobs/knobs.dart';
import '../../navigation/navigation.dart';

/// Base class for all Widgetbook addons.
///
/// [WidgetbookAddon]s are global configuration tools that affect all
/// [WidgetbookUseCase]s in your Widgetbook. Unlike [Knob]s, which operate
/// at the individual use case level, addons provide cross-cutting functionality
/// such as theming, localization, viewport simulation, and more.
///
/// Learn more:
/// * https://docs.widgetbook.io/addons/overview
/// * https://docs.widgetbook.io/addons/custom-addon
@optionalTypeArgs
abstract class WidgetbookAddon<T> extends FieldsComposable<T> {
  /// Creates a [WidgetbookAddon] with the given [name].
  WidgetbookAddon({
    required super.name,
    @Deprecated('Use local field instead') this.initialSetting,
  });

  /// @nodoc
  @Deprecated('Use local field instead')
  final T? initialSetting;

  @override
  String get groupName => slugify(name);

  /// Builds the wrapper widget for use cases based on the current [setting].
  ///
  /// This method is called for every use case and allows the addon to wrap
  /// the use case widget with additional functionality. The [setting] parameter
  /// contains the current value selected by the user in the addon's UI.
  ///
  /// By default, this method returns the [child] widget unchanged. Override
  /// this method to implement the addon's functionality.
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    T setting,
  ) {
    return child;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'group': groupName,
      'fields': fields.map((field) => field.toFullJson()).toList(),
    };
  }
}
