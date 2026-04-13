// Tests that nullable type arguments within generic bounds
// (e.g. <D, T extends Wrapper<D?>>) are preserved in generated code.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'preserves nullable type arguments on generic bounds',
    () async {
      await testStoryGenerator('generic_bound_nullable');
    },
  );
}
