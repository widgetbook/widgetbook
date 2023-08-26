import 'package:test/test.dart';
import 'package:widgetbook_generator/instances/list_instance.dart';
import 'package:widgetbook_generator/instances/property.dart';
import 'package:widgetbook_generator/instances/widgetbook_component_instance.dart';
import 'package:widgetbook_generator/instances/widgetbook_use_case_instance.dart';
import 'package:widgetbook_generator/models/element_metadata.dart';
import 'package:widgetbook_generator/models/use_case_metadata.dart';

import 'instance_helper.dart';

void main() {
  group(
    '$WidgetbookComponentInstance',
    () {
      const widgetName = 'CustomWidget';

      final instance = WidgetbookComponentInstance(
        name: widgetName,
        useCases: [
          UseCaseMetadata(
            designLink: null,
            functionName: 'story1',
            name: 'Story1',
            importUri: '',
            filePath: 'a',
            component: ElementMetadata(
              name: widgetName,
              importUri: '',
              filePath: 'a',
            ),
          ),
          UseCaseMetadata(
            designLink: null,
            functionName: 'story2',
            name: 'Story2',
            importUri: '',
            filePath: 'a',
            component: ElementMetadata(
              name: widgetName,
              importUri: '',
              filePath: 'a',
            ),
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
