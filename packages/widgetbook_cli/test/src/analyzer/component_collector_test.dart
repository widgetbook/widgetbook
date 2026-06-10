import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/analyzer/collectors/component_collector.dart';

void main() {
  group('$ComponentCollector', () {
    Set<String> collect(String source) {
      final unit = parseString(content: source).unit;
      final collector = ComponentCollector();
      unit.accept(collector);
      return collector.data;
    }

    test('collects widget from Meta constructor tear-offs', () {
      final components = collect('''
const meta = Meta(CustomCard.new);
const iconMeta = Meta(MyButton.icon);
const keywordMeta = const Meta(KeywordWidget.new);
''');

      expect(
        components,
        {'CustomCard', 'MyButton', 'KeywordWidget'},
      );
    });

    test('collects widget from Meta with argsType, not the args class', () {
      final components = collect('''
const meta = Meta(RatingWidget.new, argsType: RatingArgs.new);
const namedFirst = Meta(argsType: BadgeArgs.new, BadgeWidget.new);
''');

      expect(components, {'RatingWidget', 'BadgeWidget'});
    });

    test('deduplicates variants of the same widget', () {
      final components = collect('''
const meta = Meta(MyButton.new);
const iconMeta = Meta(MyButton.icon);
''');

      expect(components, {'MyButton'});
    });

    test('ignores ComponentMeta and unrelated variables', () {
      final components = collect('''
const component = ComponentMeta(name: 'Button');
const unrelated = Object();
final list = [1, 2, 3];
''');

      expect(components, isEmpty);
    });
  });
}
