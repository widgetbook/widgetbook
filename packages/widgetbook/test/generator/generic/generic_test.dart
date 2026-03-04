// Tests that generic type parameters (e.g. <T extends num>) are propagated
// through all generated classes: Story<T>, Args<T>, Scenario<T>, and their
// corresponding typedefs.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'propagates generic type parameters through generated classes',
    () async {
      await testStoryGenerator('generic');
    },
  );
}
