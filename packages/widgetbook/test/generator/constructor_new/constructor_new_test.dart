// Tests that Widget.new is treated as the unnamed constructor, producing the
// same output as Meta<Widget>() without a constructor parameter.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'treats Widget.new as the unnamed constructor',
    () async {
      await testStoryGenerator('constructor_new');
    },
  );
}
