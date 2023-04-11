import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_addon_data.dart';

class CustomAddonInstance extends Instance {
  CustomAddonInstance({
    required WidgetbookAddonData addon,
  }) : super(
          name: addon.name,
          properties: [
            Property(
              key: 'setting',
              instance: VariableInstance(
                variableIdentifier: addon.variableName,
              ),
            ),
          ],
        );
}
