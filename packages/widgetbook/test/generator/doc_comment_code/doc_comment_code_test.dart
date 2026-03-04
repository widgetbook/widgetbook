// Tests that doc comments containing code with $ interpolation are correctly
// escaped in the generated output.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'generates correct docComment for doc comments with code containing \$ signs',
    () async {
      await testStoryGenerator('doc_comment_code');
    },
  );
}
