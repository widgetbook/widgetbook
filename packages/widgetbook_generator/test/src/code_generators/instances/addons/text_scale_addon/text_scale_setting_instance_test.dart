import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';

void main() {
  group('$TextScaleSettingInstance', () {
    test(
      '.name returns "TextScaleSetting"',
      () {
        expect(
          TextScaleSettingInstance(textScales: const [1.0, 2.0]).name,
          equals('TextScaleSetting'),
        );
      },
    );
  });
}
