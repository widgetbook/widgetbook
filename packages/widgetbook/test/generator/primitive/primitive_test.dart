// Tests that required primitive params (String, int, bool) generate correct
// Story and Args classes with StringArg, IntArg, BoolArg initializers,
// typed getters, and a default builder that instantiates the widget.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('generates Story and Args classes for primitive types', () async {
    await testStoryGenerator('primitive');
  });
}
