import 'package:widgetbook_generator/code_generators/instances/instances.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localizations_delegates_data.dart';

class LocalizationAddonInstance extends AddOnInstance {
  LocalizationAddonInstance({
    required WidgetbookLocalesData localesData,
    required WidgetbookLocalizationsDelegatesData localizationDelegatesData,
  }) : super(
          name: 'LocalizationAddon',
          properties: [
            Property(
              key: 'setting',
              instance: LocalizationSettingInstance(
                localesData: localesData,
                localizationDelegatesData: localizationDelegatesData,
              ),
            ),
          ],
        );
}
