/// Annotates a code element to create the widgetbook main file in the same
/// folder in which the annotated element is defined.
class App {
  const App({
    this.foldersExpanded = false,
    this.widgetsExpanded = false,
  });

  /// Determines folders are expanded by default
  final bool foldersExpanded;

  /// Determines widgets are expanded by default
  final bool widgetsExpanded;
}
