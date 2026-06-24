import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

// Uses a generated args class from the generator fixtures, so the test runs
// against real generator output.
import '../../generator/primitive/primitive.stories.dart';

void main() {
  // `StoryArgs.list` includes args from both the default and `.fixed`
  // constructors, and the UI reads `Arg.name` for each of them (e.g. to label
  // a scenario's args). So `name` must resolve for both.
  group('Arg.name for generated StoryArgs', () {
    test('default constructor exposes parameter names', () {
      final args = PrimitiveWidgetArgs();

      final names = args.list.whereType<Arg>().map((arg) => arg.name).toList();

      expect(names, containsAll(['label', 'count', 'isActive']));
    });

    test('fixed constructor exposes parameter names', () {
      final args = PrimitiveWidgetArgs.fixed(
        label: 'Hello',
        count: 1,
        isActive: true,
      );

      final names = args.list.whereType<Arg>().map((arg) => arg.name).toList();

      expect(names, containsAll(['label', 'count', 'isActive']));
    });
  });
}
