import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$AppInfoInstance',
    () {
      const appInfoName = 'Recipe App';
      final instance = AppInfoInstance(name: appInfoName);

      testName('AppInfo', instance: instance);

      test(
        '.properties returns one property',
        () {
          expect(
            instance.properties,
            equals(
              [
                Property.string(
                  key: 'name',
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
