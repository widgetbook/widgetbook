import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

void main() {
  group(
    '$App',
    () {
      test('defaults to empty list', () {
        const instance = App.material();

        expect(
          instance.devices,
          isEmpty,
        );
      });
    },
  );
}
