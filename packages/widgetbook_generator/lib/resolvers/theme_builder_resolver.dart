import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_builder_data.dart';
import 'package:widgetbook_generator/resolvers/builder_function_resolver.dart';

class ThemeBuilderResolver
    extends BuilderFunctionResolver<WidgetbookThemeBuilder> {
  ThemeBuilderResolver()
      : super(
          createData: (
            name,
            imports,
            dependencies,
          ) =>
              WidgetbookThemeBuilderData(
            name: name,
            importStatement: imports,
            dependencies: dependencies,
          ),
        );
}
