import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

void main() {
  group(
    '$Model',
    () {
      test(
        'returns normally',
        () {
          expect(
            () => const Model(id: '1'),
            returnsNormally,
          );
        },
      );
    },
  );
}
