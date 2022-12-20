import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/addon_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

/// An instance for Widgetbook
class WidgetbookInstance extends Instance {
  /// Creates a new instance of [WidgetbookInstance]
  WidgetbookInstance({
    required AppInfoInstance appInfoInstance,
    required WidgetbookConstructor constructor,
    required List<WidgetbookCategoryInstance> categories,
    required List<AddOnInstance> addons,
    String? type,
    VariableInstance? appBuilder,
  }) : super(
          name: 'Widgetbook',
          namedConstructor: constructor.toCode,
          genericParameters: type != null ? [type] : [],
          properties: [
            Property(key: 'appInfo', instance: appInfoInstance),
            Property(
              key: 'addons',
              instance: ListInstance(instances: addons),
            ),
            Property(
              key: 'categories',
              instance: ListInstance(instances: categories),
            ),
            if (appBuilder != null)
              Property(
                key: 'appBuilder',
                instance: appBuilder,
              ),
          ],
        );
}
