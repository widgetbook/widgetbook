import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_use_case_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_widget_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_data.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$WidgetbookComponentInstance',
    () {
      const widgetName = 'CustomWidget';

      final instance = WidgetbookComponentInstance(
        name: widgetName,
        stories: [
          WidgetbookUseCaseData(
            designLink: null,
            name: 'story1',
            importStatement: '',
            componentImportStatement: '',
            dependencies: [],
            useCaseName: 'Story1',
            componentName: widgetName,
            useCaseDefinitionPath: 'a',
            componentDefinitionPath: 'a',
          ),
          WidgetbookUseCaseData(
            designLink: null,
            name: 'story2',
            importStatement: '',
            componentImportStatement: '',
            dependencies: [],
            useCaseName: 'Story2',
            componentName: widgetName,
            useCaseDefinitionPath: 'a',
            componentDefinitionPath: 'a',
          ),
        ],
      );

      testName('WidgetbookComponent', instance: instance);

      test(
        '.properties returns a StringProperty and Property containing a list',
        () {
          expect(
            instance.properties,
            equals(
              [
                Property.string(
                  key: 'name',
                  value: widgetName,
                ),
                Property(
                  key: 'useCases',
                  instance: ListInstance(
                    instances: [
                      WidgetbookUseCaseInstance(
                        useCaseName: 'Story1',
                        functionName: 'story1',
                      ),
                      WidgetbookUseCaseInstance(
                        useCaseName: 'Story2',
                        functionName: 'story2',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
