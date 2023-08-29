import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

void main() {
  test('referWidgetbook', () {
    final actual = referWidgetbook('WidgetbookType');

    expect(actual.url, widgetbookUrl);
  });
}
