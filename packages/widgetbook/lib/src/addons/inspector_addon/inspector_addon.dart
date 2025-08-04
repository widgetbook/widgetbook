import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for enabling widget inspection and debugging tools.
///
/// The addon integrates the [inspector](https://pub.dev/packages/inspector)
/// package to provide advanced debugging capabilities directly within
/// Widgetbook. When enabled, it overlays interactive inspection tools that
/// help developers analyze widget structure, properties, and layout behavior.
///
/// Learn more: https://docs.widgetbook.io/addons/inspector-addon
class InspectorAddon extends WidgetbookAddon<bool> {
  /// Creates a new instance of [InspectorAddon].
  InspectorAddon({
    this.enabled = false,
  }) : super(
         name: 'Inspector',
       );

  /// The default enabled state for the inspector when the addon loads.
  ///
  /// When true, the inspector starts active and immediately provides
  /// debugging overlays. When false, users must manually enable it
  /// through the Widgetbook interface.
  ///
  /// This setting is useful for different development scenarios:
  /// - `true`: When actively debugging layout issues
  /// - `false`: For normal development to reduce visual clutter
  final bool enabled;

  /// Generates the inspector toggle control field.
  ///
  /// Creates a [BooleanField] that allows users to enable or disable
  /// the widget inspector overlay. The toggle provides immediate
  /// feedback, showing or hiding inspection tools in real-time.
  ///
  /// The field appears as a checkbox labeled "Inspector" in the
  /// Widgetbook interface, allowing quick toggling during development.
  @override
  List<Field> get fields => [
    BooleanField(
      name: 'isEnabled',
      initialValue: enabled,
    ),
  ];

  /// Extracts the inspector enabled state from URL query parameters.
  ///
  /// Parses the 'isEnabled' parameter from the query group to restore
  /// the inspector state when loading from URLs or sharing links.
  /// Defaults to false if no parameter is found.
  ///
  /// This enables consistent inspector state when reproducing specific
  /// debugging scenarios or sharing use case configurations with
  /// team members who need the same inspection setup.
  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('isEnabled', group) ?? false;
  }

  /// Conditionally wraps the use case with inspector functionality.
  ///
  /// When [setting] is true, wraps the child widget with the [Inspector]
  /// widget that provides interactive debugging tools. When false,
  /// returns the child unchanged for normal rendering.
  ///
  /// Parameters:
  ///   * [context] - The build context for the widget
  ///   * [child] - The use case widget to optionally wrap with inspection
  ///   * [setting] - Whether the inspector should be enabled
  ///
  /// ## Inspector Behavior
  ///
  /// When enabled, the inspector overlays provide:
  /// - Interactive widget selection by tapping
  /// - Real-time property display
  /// - Visual layout bounds and constraints
  /// - Widget hierarchy navigation
  /// - Performance debugging information
  ///
  /// The inspector is forced to enabled state (`isEnabled: true`) to
  /// bypass automatic disabling in release builds, ensuring it works
  /// consistently in Widgetbook regardless of build configuration.
  ///
  /// Returns either the original child widget or the child wrapped
  /// with inspector debugging capabilities.
  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    bool setting,
  ) {
    if (!setting) return child;

    return Inspector(
      isEnabled: true, // To bypass disabling on release builds
      child: child,
    );
  }
}
