import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_localization_builder_data.dart';
import 'package:widgetbook_generator/resolvers/builder_function_resolver.dart';

class LocalizationBuilderResolver
    extends BuilderFunctionResolver<WidgetbookLocalizationBuilder> {
  LocalizationBuilderResolver()
      : super(
          createData: (
            name,
            imports,
            dependencies,
          ) =>
              WidgetbookLocalizationBuilderData(
            name: name,
            importStatement: imports,
            dependencies: dependencies,
          ),
        );
}
