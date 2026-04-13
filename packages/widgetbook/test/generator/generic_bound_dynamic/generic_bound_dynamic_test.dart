// Tests that dynamic type arguments within generic bounds
// (e.g. <D, T extends Map<dynamic, D>>) are preserved in generated code.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'preserves dynamic type arguments on generic bounds',
    () async {
      await testStoryGenerator('generic_bound_dynamic');
    },
  );
}
