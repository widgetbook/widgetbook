final class CoverageArgs {
  const CoverageArgs({
    required this.package,
    required this.widgetbook,
    required this.minCoverage,
  });

  /// The path to the app or the package that has the widgets.
  final String package;

  /// The path to the widgetbook app. Usually located
  /// within "[package]/widgetbook".
  final String widgetbook;

  /// The minimum coverage percentage required to pass the check.
  final int minCoverage;
}
