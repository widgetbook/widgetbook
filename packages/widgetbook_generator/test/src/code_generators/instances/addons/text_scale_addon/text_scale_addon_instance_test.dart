import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';

void main() {
  group(
    '$TextScaleAddonInstance',
    () {
      test('.name is "TextScaleAddon"', () {
        final sut = TextScaleAddonInstance(textScales: const [1, 2]);
        expect(sut.name, equals('TextScaleAddon'));
      });
    },
  );
}
