import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/model.dart';

void main() {
  group(
    '$Model',
    () {
      test(
        'returns normally',
        () {
          expect(
            () => Model(id: '1'),
            returnsNormally,
          );
        },
      );
    },
  );
}
