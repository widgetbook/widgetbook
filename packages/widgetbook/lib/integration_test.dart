/// On-device snapshotting for Widgetbook, built on `package:integration_test`.
///
/// Use `testWidgetbookOnDevice` as the entrypoint of an `integration_test`
/// target to capture scenarios on a real device or simulator, where
/// platform-backed widgets (e.g. `video_player`, `pdfrx`) render for real.
/// Pair it with `widgetbookIntegrationDriver` from
/// `package:widgetbook/integration_test_driver.dart` and run via `flutter drive`.
library;

export 'src/test/on_device_test.dart' show testWidgetbookOnDevice;
