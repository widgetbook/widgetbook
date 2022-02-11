import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_mode_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

import '../instance_helper.dart';

void main() {
  group('$WidgetbookInstance', () {
    const appInfoName = 'Recipe App';

    testName(
      'Widgetbook',
      instance: WidgetbookInstance(
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

    test(
      '.properties returns $AppInfoInstance and '
      'List<$WidgetbookCategoryInstance>',
      () {
        final instance = WidgetbookInstance(
          appInfoInstance: AppInfoInstance(name: appInfoName),
          categories: const [],
          themes: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedCategoryInstance,
          ]),
        );
      },
    );

    test(
      '.properties returns all properties',
      () {
        final instance = WidgetbookInstance(
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

    const expectedThemeModeInstanceDark = Property(
      key: 'defaultTheme',
      instance: ThemeModeInstance(name: 'dark'),
    );

    const expectedThemeModeInstanceLight = Property(
      key: 'defaultTheme',
      instance: ThemeModeInstance(name: 'light'),
    );

    test(
      '.properties returns $AppInfoInstance, '
      'List<$WidgetbookCategoryInstance> and dark theme',
      () {
        final instance = WidgetbookInstance(
          appInfoInstance: AppInfoInstance(name: appInfoName),
          categories: const [],
          themes: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedThemeModeInstanceDark,
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
          appInfoInstance: AppInfoInstance(name: appInfoName),
          categories: const [],
          themes: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedThemeModeInstanceLight,
            expectedCategoryInstance,
          ]),
        );
      },
    );
  });
}
