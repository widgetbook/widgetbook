final class CoverageArgs {
  const CoverageArgs({
    required this.package,
    required this.widgetbook,
    required this.widgetsTarget,
    required this.widgetbookUsecasesTarget,
    required this.minCoverage,
  });

  final String package;
  final String widgetbook;
  final String widgetsTarget;
  final String widgetbookUsecasesTarget;
  final int minCoverage;
}
