import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

/// An instance for AppInfo
class AppInfoInstance extends Instance {
  /// Creates a new instance of [AppInfoInstance]
  AppInfoInstance({
    required String name,
  }) : super(
          name: 'AppInfo',
          properties: [
            Property.string(key: 'name', value: name),
          ],
        );
}
