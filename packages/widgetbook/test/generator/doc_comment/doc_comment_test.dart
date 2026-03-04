// Tests that doc comments with empty lines (///) are correctly stripped
// without leaving orphaned /// markers in the generated output.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('generates correct docComment for doc comments with empty lines',
      () async {
    await testStoryGenerator('doc_comment');
  });
}
