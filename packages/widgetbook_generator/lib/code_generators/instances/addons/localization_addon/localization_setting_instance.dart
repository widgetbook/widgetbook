import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localizations_delegates_data.dart';

class LocalizationSettingInstance extends Instance {
  LocalizationSettingInstance({
    required WidgetbookLocalesData localesData,
    required WidgetbookLocalizationsDelegatesData localizationDelegatesData,
  }) : super(
          name: 'LocalizationSetting',
          properties: [
            Property(
              key: 'locales',
              instance: VariableInstance(variableIdentifier: localesData.name),
            ),
            // TODO this is a big hacky
            Property(
              key: 'activeLocale',
              instance: VariableInstance(
                variableIdentifier: '${localesData.name}.first',
              ),
            ),
            Property(
              key: 'localizationsDelegates',
              instance: VariableInstance(
                variableIdentifier: localizationDelegatesData.name,
              ),
            ),
          ],
        );
}
