import 'package:widgetbook_generator/code_generators/code_generator.dart';
import 'package:widgetbook_generator/code_generators/properties/string_property.dart';

class AppInfoGenerator extends CodeGenerator {
  AppInfoGenerator({
    required String name,
  }) : super(
          instanceName: 'AppInfo',
          properties: [
            StringProperty(
              key: 'name',
              value: name,
            ),
          ],
        );
}
