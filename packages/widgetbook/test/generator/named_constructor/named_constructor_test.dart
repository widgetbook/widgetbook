// Tests that the generator uses the specified named constructor's parameters
// when Meta(constructor: ...) is provided.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'uses named constructor parameters when constructor is specified',
    () async {
      await testStoryGenerator('named_constructor');
    },
  );
}
