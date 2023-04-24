import 'package:widgetbook_models/widgetbook_models.dart';

import 'constructor.dart';

/// Annotates a code element to create the widgetbook main file in the same
/// folder in which the annotated element is defined.
class App {
  /// Creates a new annotation optional [devices] and [textScaleFactors].
  /// If devices is not set or set to an empty list, no code for the
  /// Widgetbook.devices property will be generated.
  /// Therefore, the default of Widgetbook will be used.
  const App({
    required Type this.themeType,
    this.devices = const <Device>[],
    this.textScaleFactors = const <double>[],
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
    this.constructor = Constructor.custom,
  });

  /// Annotates a code element to creat a Material-themed widgetbook main file
  /// in the same folder in which the annotated element is defined.
  const App.material({
    this.devices = const <Device>[],
    this.textScaleFactors = const <double>[],
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
    this.constructor = Constructor.material,
  }) : themeType = null;

  /// Annotates a code element to creat a Cupertino-themed widgetbook main
  /// file in the same folder in which the annotated element is defined.
  const App.cupertino({
    this.devices = const <Device>[],
    this.textScaleFactors = const <double>[],
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
    this.constructor = Constructor.cupertino,
  }) : themeType = null;

  /// The type of the ThemeData.
  final Type? themeType;

  /// Indicates which type of theme is used for the generic Widgetbook
  /// implementation.
  final Constructor constructor;

  /// The devices shown in the Widgetbook
  final List<Device> devices;

  /// A list of text scale factors
  final List<double> textScaleFactors;

  /// Determines folders are expanded by default
  final bool foldersExpanded;

  /// Determines widgets are expanded by default
  final bool widgetsExpanded;
}
