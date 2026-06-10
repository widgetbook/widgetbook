// Tests that multiple Meta variables generate one set of types per
// constructor variant: unnamed (`_Story`), named (`_IconStory`), and
// factory (`_OutlinedStory`) constructors, with per-variant defaults
// matched by their initializer type instead of their variable name.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'generates prefixed types per constructor variant',
    () async {
      await testStoryGenerator('variants');
    },
  );
}
