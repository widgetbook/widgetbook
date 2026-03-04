// Tests that a top-level `defaults` variable pipes defaults.setup and
// defaults.builder into the Story's super constructor initializers.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('pipes defaults.setup and defaults.builder into Story', () async {
    await testStoryGenerator('with_defaults');
  });
}
