// Tests MetaWithArgs<LabelBadge, NumericBadgeInput> where the custom args type
// has different fields (int number) than the widget (String text). Verifies
// that the Args class is derived from NumericBadgeInput (not LabelBadge),
// the builder parameter is required, no default builder is auto-generated,
// and that defaults.builder is piped into the Story super constructor.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test('generates required builder when using MetaWithArgs', () async {
    await testStoryGenerator('custom');
  });
}
