final class InitArgs {
  const InitArgs({
    required this.packageDir,
    required this.outputDir,
    required this.empty,
  });

  /// The path to the app or the package that has the widgets.
  final String packageDir;

  /// The path to where widgetbook should be initialized.
  final String outputDir;

  /// Whether to skip generating stories for the existing widgets, leaving an
  /// empty workspace that is wired up to use Widgetbook.
  final bool empty;
}
