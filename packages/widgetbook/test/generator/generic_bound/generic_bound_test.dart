// Tests that generic type parameter bounds with type arguments
// (e.g. <D, T extends BaseItem<D>>) are preserved in generated code.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'preserves type arguments on generic bounds',
    () async {
      await testStoryGenerator('generic_bound');
    },
  );
}
