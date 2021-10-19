import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

void main() {
  group(
    '$WidgetbookApp',
    () {
      test('defaults to empty list', () {
        const instance = WidgetbookApp(name: 'Test');

        expect(
          instance.devices,
          isEmpty,
        );
      });
    },
  );
}
