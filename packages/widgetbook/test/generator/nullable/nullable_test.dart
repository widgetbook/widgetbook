// Tests that nullable params (String?, int?) generate nullable Arg fields
// (Arg<T?>?), NullableStringArg/NullableIntArg initializers, and null-safe
// getters using ?.value.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('generates nullable Arg fields for nullable params', () async {
    await testStoryGenerator('nullable');
  });
}
