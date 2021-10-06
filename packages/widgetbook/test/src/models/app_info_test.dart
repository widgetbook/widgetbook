import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/app_info.dart';

void main() {
  group(
    '$AppInfo',
    () {
      test(
        'returns normally',
        () {
          expect(
            () => AppInfo(name: 'Name'),
            returnsNormally,
          );
        },
      );
    },
  );
}
