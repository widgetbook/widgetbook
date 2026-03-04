// Tests that static methods used as default parameter values are
// properly qualified with the class name in the generated code.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('generates args with static method default values', () async {
    await testStoryGenerator('static_methods');
  });
}
