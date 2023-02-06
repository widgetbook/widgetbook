import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/addon_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group('$WidgetbookInstance', () {
    testName(
      'Widgetbook',
      instance: WidgetbookInstance(
        addons: const [],
        constructor: WidgetbookConstructor.material,
        directories: const [],
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

    test(
      '.properties returns '
      'List<$WidgetbookCategoryInstance>',
      () {
        final instance = WidgetbookInstance(
          addons: const [],
          constructor: WidgetbookConstructor.material,
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
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
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAddonsProperty,
            expectedCategoryInstance,
          ]),
        );
      },
    );

    test(
      '.properties '
      'List<$WidgetbookCategoryInstance> and dark theme',
      () {
        final instance = WidgetbookInstance(
          addons: const [],
          constructor: WidgetbookConstructor.material,
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAddonsProperty,
            expectedCategoryInstance,
          ]),
        );
      },
    );

    test(
      '.properties returns '
      'List<$WidgetbookCategoryInstance> and light theme',
      () {
        final instance = WidgetbookInstance(
          addons: const [],
          constructor: WidgetbookConstructor.material,
          directories: const [],
        );

        expect(
          instance.properties,
          equals([
            expectedAddonsProperty,
            expectedCategoryInstance,
          ]),
        );
      },
    );
  });
}
