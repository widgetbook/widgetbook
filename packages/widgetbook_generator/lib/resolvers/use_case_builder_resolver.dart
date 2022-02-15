import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_builder_data.dart';
import 'package:widgetbook_generator/resolvers/builder_function_resolver.dart';

class UseCaseBuilderResolver
    extends BuilderFunctionResolver<WidgetbookUseCaseBuilder> {
  UseCaseBuilderResolver()
      : super(
          createData: (
            name,
            imports,
            dependencies,
          ) =>
              WidgetbookUseCaseBuilderData(
            name: name,
            importStatement: imports,
            dependencies: dependencies,
          ),
        );
}
