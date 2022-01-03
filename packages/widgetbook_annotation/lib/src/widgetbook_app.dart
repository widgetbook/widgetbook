import 'package:widgetbook_annotation/src/widgetbook_theme.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Annotates a code element to create the widgetbook main file in the same
/// folder in which the annotated element is defined.
class WidgetbookApp {
  /// Creates a new annotation with [name] and optional [devices].
  /// If devices is not set or set to an empty list, no code for the
  /// Widgetbook.devices property will be generated.
  /// Therefore, the default of Widgetbook will be used.
  const WidgetbookApp({
    required this.name,
    this.devices = const <Device>[],
    this.defaultTheme,
  });

  /// The devices shown in the Widgetbook
  final List<Device> devices;

  /// The name of the widgetbook.
  /// This information will be displayed at the top left corner in the UI.
  final String name;

  /// Set default theme mode. If not specified, system theme mode is used.
  final WidgetbookTheme? defaultTheme;
}
