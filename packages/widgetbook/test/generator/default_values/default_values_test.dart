// Tests that explicit default values (this.label = 'hello', this.count = 42)
// are propagated into Arg initializers (StringArg('hello'), IntArg(42)) and
// into the .fixed() constructor parameters.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('generates args with explicit default values', () async {
    await testStoryGenerator('default_values');
  });
}
