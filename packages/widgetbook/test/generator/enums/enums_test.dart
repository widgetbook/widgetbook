// Tests that enum params generate EnumArg<T> with T.values passed as the
// enum values list.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('generates EnumArg for enum parameters', () async {
    await testStoryGenerator('enums');
  });
}
