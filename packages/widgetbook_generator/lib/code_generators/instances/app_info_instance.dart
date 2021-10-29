import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class AppInfoInstance extends Instance {
  AppInfoInstance({
    required String name,
  }) : super(
          name: 'AppInfo',
          properties: [
            Property.string(key: 'name', value: name),
          ],
        );
}
