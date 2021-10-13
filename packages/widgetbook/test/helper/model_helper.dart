import 'package:flutter_test/flutter_test.dart';

void expectEqualHashCodes(
  Object instance1,
  Object instance2,
) {
  expect(
    instance1.hashCode == instance2.hashCode,
    isTrue,
  );
}
