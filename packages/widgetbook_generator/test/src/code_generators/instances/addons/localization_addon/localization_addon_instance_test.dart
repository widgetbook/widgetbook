import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localizations_delegates_data.dart';

void main() {
  group(
    '$LocalizationAddonInstance',
    () {
      test('.name is "LocalizationAddon"', () {
        final sut = LocalizationAddonInstance(
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
        );
        expect(sut.name, equals('LocalizationAddon'));
      });
    },
  );
}
