import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localizations_delegates_data.dart';

void main() {
  group('$LocalizationSettingInstance', () {
    test(
      '.name returns "LocalizationSetting"',
      () {
        expect(
          LocalizationSettingInstance(
            localesData: WidgetbookLocalesData(
              name: 'locales',
              importStatement: '',
              dependencies: [],
              locales: [],
            ),
            localizationDelegatesData: WidgetbookLocalizationsDelegatesData(
              name: 'delegates',
              importStatement: '',
              dependencies: [],
            ),
          ).name,
          equals('LocalizationSetting'),
        );
      },
    );
  });
}
