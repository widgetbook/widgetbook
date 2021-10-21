import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

void main() {
  group('$WidgetbookTheme', () {
    test(
      '.light() sets isDarkTheme to false',
      () {
        expect(
          const WidgetbookTheme.light().isDarkTheme,
          isFalse,
        );
      },
    );

    test(
      '.dark() sets isDarkTheme to true',
      () {
        expect(
          const WidgetbookTheme.dark().isDarkTheme,
          isTrue,
        );
      },
    );
  });
}
