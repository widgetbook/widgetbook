import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/addon_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
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
        addons: const [],
        constructor: WidgetbookConstructor.material,
        appInfoInstance: AppInfoInstance(name: appInfoName),
        directories: const [],
      ),
    );

    final expectedAppInfoProperty = Property(
      key: 'appInfo',
      instance: AppInfoInstance(
        name: appInfoName,
      ),
    );

    const expectedCategoryInstance = Property(
      key: 'directories',
      instance: ListInstance<WidgetbookCategoryInstance>(
        instances: [],
      ),
    );

    const expectedAddonsProperty = Property(
      key: 'addons',
      instance: ListInstance<AddOnInstance>(
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
          addons: const [],
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedAddonsProperty,
            expectedCategoryInstance,
          ]),
        );
      },
    );

    test(
      '.properties returns all properties',
      () {
        final instance = WidgetbookInstance(
          addons: const [],
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedAddonsProperty,
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
          addons: const [],
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedAddonsProperty,
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
          addons: const [],
          constructor: WidgetbookConstructor.material,
          appInfoInstance: AppInfoInstance(name: appInfoName),
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAppInfoProperty,
            expectedAddonsProperty,
            expectedCategoryInstance,
          ]),
        );
      },
    );
  });
}
