/// Annotates a code element to create the widgetbook main file in the same
/// folder in which the annotated element is defined.
class App {
  /// Creates a new annotation optional [devices] and [textScaleFactors].
  /// If devices is not set or set to an empty list, no code for the
  /// Widgetbook.devices property will be generated.
  /// Therefore, the default of Widgetbook will be used.
  const App({
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
  });

  /// Determines folders are expanded by default
  final bool foldersExpanded;

  /// Determines widgets are expanded by default
  final bool widgetsExpanded;
}
