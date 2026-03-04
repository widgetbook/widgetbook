// Tests that the generator uses the unnamed constructor when a class has
// multiple constructors, even when a named constructor is declared first.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'uses unnamed constructor when named constructor is declared first',
    () async {
      await testStoryGenerator('multi_constructor');
    },
  );
}
