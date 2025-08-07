final class CoverageArgs {
  const CoverageArgs({
    required this.packageDir,
    required this.widgetbookDir,
    required this.minCoverage,
  });

  /// The path to the app or the package that has the widgets.
  final String packageDir;

  /// The path to the widgetbook app. Usually located
  /// within "[packageDir]/widgetbook".
  final String widgetbookDir;

  /// The minimum coverage percentage required to pass the check.
  final int minCoverage;
}
