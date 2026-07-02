import 'package:flutter_test/flutter_test.dart';

// Uses a generated story class from the generator fixtures, so the test runs
// against real generator output.
import '../../generator/primitive/primitive.stories.dart';

void main() {
  // The Cloud "View in Figma" review feature reads `Story.designLink` from
  // the snapshot metadata, so the generated constructor must forward it.
  test('generated story constructor forwards designLink', () {
    final story = PrimitiveWidgetStory(
      designLink: 'https://www.figma.com/file/abc123',
    );

    expect(story.designLink, 'https://www.figma.com/file/abc123');
  });

  test('designLink defaults to null', () {
    final story = PrimitiveWidgetStory();

    expect(story.designLink, isNull);
  });
}
