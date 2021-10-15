import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_generator/generators/widgetbook_generator.dart';
import 'package:widgetbook_generator/resolvers/theme_resolver.dart';

import 'builders/json_builder.dart';

Builder themeBuilder(BuilderOptions options) {
  return JsonLibraryBuilder(
    ThemeResolver(),
    formatOutput: formatOutput,
    generatedExtension: '.theme.widgetbook.json',
  );
}

Builder widgetbookBuilder(BuilderOptions options) {
  return LibraryBuilder(
    WidgetbookGenerator(),
    generatedExtension: '.widgetbook.dart',
  );
}

String formatOutput(String input) {
  return input;
}
