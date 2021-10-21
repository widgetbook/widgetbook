import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/src/widgetbook_story.dart';

void main() {
  group('$WidgetbookStory', () {
    test('creates instance', () {
      const instance = WidgetbookStory(name: 'Test', type: int);

      expect(
        instance.name,
        equals('Test'),
      );
      expect(
        instance.type,
        equals(int),
      );
    });
  });
}
