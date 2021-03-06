import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group('$WidgetbookInstance', () {
    const appInfoName = 'Recipe App';

    testName(
      'Widgetbook',
      instance: WidgetbookInstance(
        constructor: WidgetbookConstructor.material,
        appInfoInstance: AppInfoInstance(name: appInfoName),
        categories: const [],
        themes: const [],
      ),
    );

    final expectedAppInfoProperty = Property(
      key: 'appInfo',
      instance: AppInfoInstance(
        name: appInfoName,
      ),
    );

    const expectedCategoryInstance = Property(
      key: 'categories',
      instance: ListInstance<WidgetbookCategoryInstance>(
        instances: [],
      ),
    );

    const expectedThemesInstance = Property(
      key: 'themes',
      instance: ListInstance<ThemeInstance>(
        instances: [],
      ),
    );

    test(
      '.properties returns $AppInfoInstance and '
      'List<$WidgetbookCategoryInstance>',
      () {
        final instance = WidgetbookInstance(
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          categories: const [],
          themes: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedThemesInstance,
            expectedCategoryInstance,
          ]),
        );
      },
    );

    test(
      '.properties returns all properties',
      () {
        final instance = WidgetbookInstance(
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          themes: const [],
          devices: [
            DeviceInstance(device: Apple.iPhone11),
            DeviceInstance(device: Apple.iPhone12),
          ],
          categories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            const Property(
              key: 'themes',
              instance: ListInstance(
                instances: <ThemeInstance>[],
              ),
            ),
            Property(
              key: 'devices',
              instance: ListInstance(
                instances: [
                  DeviceInstance(device: Apple.iPhone11),
                  DeviceInstance(device: Apple.iPhone12)
                ],
              ),
            ),
            expectedCategoryInstance,
          ]),
        );
      },
    );

    test(
      '.properties returns $AppInfoInstance, '
      'List<$WidgetbookCategoryInstance> and dark theme',
      () {
        final instance = WidgetbookInstance(
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          categories: const [],
          themes: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedThemesInstance,
            expectedCategoryInstance,
          ]),
        );
      },
    );

    test(
      '.properties returns $AppInfoInstance, '
      'List<$WidgetbookCategoryInstance> and light theme',
      () {
        final instance = WidgetbookInstance(
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          categories: const [],
          themes: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedThemesInstance,
            expectedCategoryInstance,
          ]),
        );
      },
    );
  });
}
