final class InitArgs {
  const InitArgs({
    required this.packageDir,
    required this.outputDir,
  });

  /// The path to the app or the package that has the widgets.
  final String packageDir;

  /// The path to where widgetbook should be initialized.
  final String outputDir;
}
