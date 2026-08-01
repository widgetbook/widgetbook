/// The report key under which `testWidgetbookOnDevice` hands per-scenario
/// snapshot metadata to `widgetbookIntegrationDriver` via the integration-test
/// binding's `reportData`.
///
/// Kept in its own dependency-free file so the host-side driver can share it
/// without importing any Flutter UI code (which is unavailable in the
/// `flutter drive` VM).
const widgetbookReportKey = 'widgetbook';
