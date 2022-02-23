import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_scaffold_builder_data.dart';
import 'package:widgetbook_generator/resolvers/builder_function_resolver.dart';

class ScaffoldBuilderResolver
    extends BuilderFunctionResolver<WidgetbookScaffoldBuilder> {
  ScaffoldBuilderResolver()
      : super(
          createData: (
            name,
            imports,
            dependencies,
          ) =>
              WidgetbookScaffoldBuilderData(
            name: name,
            importStatement: imports,
            dependencies: dependencies,
          ),
        );
}
