import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/addon_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

/// An instance for Widgetbook
class WidgetbookInstance extends Instance {
  /// Creates a new instance of [WidgetbookInstance]
  WidgetbookInstance({
    required WidgetbookConstructor constructor,
    required List<Instance> directories,
    required List<AddOnInstance> addons,
    String? type,
    VariableInstance? appBuilder,
  }) : super(
          name: 'Widgetbook',
          namedConstructor: constructor.toCode,
          genericParameters: type != null ? [type] : [],
          properties: [
            Property(
              key: 'addons',
              instance: ListInstance(instances: addons),
            ),
            Property(
              key: 'directories',
              instance: ListInstance(instances: directories),
            ),
            if (appBuilder != null)
              Property(
                key: 'appBuilder',
                instance: appBuilder,
              ),
          ],
        );
}
