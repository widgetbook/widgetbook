/// Host-side driver for `testWidgetbookOnDevice`.
///
/// Import this from a `test_driver/` script (run under `flutter drive`) to
/// persist the on-device snapshots into `build/.widgetbook`. It imports no
/// Flutter UI code, so it is safe in the `flutter drive` VM.
library;

export 'src/test/integration_test_driver.dart' show widgetbookIntegrationDriver;
