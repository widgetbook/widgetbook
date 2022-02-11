import 'package:widgetbook_generator/code_generators/instances/function_call_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/string_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

/// An instance of a function returning ThemeData
///
/// Since ThemeData is always returned as a function, [ThemeInstance] is based
/// on [FunctionCallInstance]
class ThemeInstance extends Instance {
  /// Creates a new instance of [ThemeInstance]
  ThemeInstance({
    required WidgetbookThemeData theme,
  }) : super(
          name: 'WidgetbookTheme',
          properties: [
            Property(
              key: 'name',
              instance: StringInstance.value(theme.themeName),
            ),
            Property(
              key: 'data',
              instance: FunctionCallInstance(
                name: theme.name,
              ),
            ),
          ],
        );
}
