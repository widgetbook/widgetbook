import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_app_builder_data.dart';
import 'package:widgetbook_generator/resolvers/builder_function_resolver.dart';

class AppBuilderResolver extends BuilderFunctionResolver<AppBuilder> {
  AppBuilderResolver()
      : super(
          createData: (
            name,
            imports,
            dependencies,
          ) =>
              WidgetbookAppBuilderData(
            name: name,
            importStatement: imports,
            dependencies: dependencies,
          ),
        );
}
