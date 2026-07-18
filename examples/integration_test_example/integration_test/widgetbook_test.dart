import 'package:integration_test_example/widgetbook.config.dart';

import 'on_device.dart';

/// On-device Widgetbook snapshot run. Drive it with:
///
/// ```sh
/// flutter drive \
///   --driver test_driver/integration_test.dart \
///   --target integration_test/widgetbook_test.dart \
///   -d <ios-simulator-or-device>
/// ```
void main() => testWidgetbookOnDevice(config);
