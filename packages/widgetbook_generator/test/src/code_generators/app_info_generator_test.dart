import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/app_info_generator.dart';
import 'package:widgetbook_generator/code_generators/properties/string_property.dart';

void main() {
  group(
    '$AppInfoGenerator',
    () {
      const appInfoName = 'Recipe App';
      test(
        'empty constructor',
        () {
          final instance = AppInfoGenerator(name: appInfoName);

          expect(
            instance.name,
            equals(
              'AppInfo',
            ),
          );

          expect(
            instance.properties,
            equals(
              [
                StringProperty(
                  name: 'name',
                  value: appInfoName,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
