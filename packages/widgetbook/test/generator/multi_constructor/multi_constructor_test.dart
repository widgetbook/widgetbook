// Tests a widget with multiple constructors where the named constructor is
// declared first:
// - `Meta(MultiConstructorWidget.new)` resolves to the unnamed constructor
//   (`count` param) regardless of declaration order.
// - `Meta(MultiConstructorWidget.other)` generates the `_OtherStory` /
//   `_OtherArgs` variant types (`label` param).
// - The component widget is inferred from the tear-offs, as no `ComponentMeta`
//   is declared.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'resolves constructor variants by tear-off regardless of declaration order',
    () async {
      await testStoryGenerator('multi_constructor');
    },
  );
}
