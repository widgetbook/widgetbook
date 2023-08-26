import 'package:test/test.dart';
import 'package:widgetbook_generator/code/refer.dart';

void main() {
  test('referWidgetbook', () {
    final actual = referWidgetbook('WidgetbookType');
    expect(actual.url, widgetbookUrl);
  });

  test('referRelative (package)', () {
    final url = 'package:foo/bar/baz/qux.dart';
    final actual = referRelative(
      'UseCase',
      url,
      'foo/lib/widgetbook.dart',
    );

    expect(actual.url, equals(url));
  });

  test('referRelative (asset)', () {
    final actual = referRelative(
      'UseCase',
      'asset:foo/bar/baz/qux.dart',
      'foo/lib/widgetbook.dart',
    );

    expect(
      actual.url,
      equals('../../bar/baz/qux.dart'),
    );
  });
}
