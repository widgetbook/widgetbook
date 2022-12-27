import 'package:widgetbook_annotation/src/widgetbook_constructor.dart';
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
    required Type this.themeType,
    this.devices = const <Device>[],
    this.textScaleFactors = const <double>[],
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
    this.constructor = WidgetbookConstructor.custom,
  });

  /// Annotates a code element to creat a Material-themed widgetbook main file
  /// in the same folder in which the annotated element is defined.
  const WidgetbookApp.material({
    required this.name,
    this.devices = const <Device>[],
    this.textScaleFactors = const <double>[],
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
    this.constructor = WidgetbookConstructor.material,
  }) : themeType = null;

  /// Annotates a code element to creat a Cupertino-themed widgetbook main
  /// file in the same folder in which the annotated element is defined.
  const WidgetbookApp.cupertino({
    required this.name,
    this.devices = const <Device>[],
    this.textScaleFactors = const <double>[],
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
    this.constructor = WidgetbookConstructor.cupertino,
  }) : themeType = null;

  /// The type of the ThemeData.
  final Type? themeType;

  /// Indicates which type of theme is used for the generic Widgetbook
  /// implementation.
  final WidgetbookConstructor constructor;

  /// The devices shown in the Widgetbook
  final List<Device> devices;

  /// A list of text scale factors
  final List<double> textScaleFactors;

  /// The name of the widgetbook.
  /// This information will be displayed at the top left corner in the UI.
  final String name;

  /// Determines folders are expanded by default
  final bool foldersExpanded;

  /// Determines widgets are expanded by default
  final bool widgetsExpanded;
}
