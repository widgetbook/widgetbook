import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_generator/builders/json_builder.dart';
import 'package:widgetbook_generator/generators/widgetbook_generator.dart';
import 'package:widgetbook_generator/resolvers/story_resolver.dart';
import 'package:widgetbook_generator/resolvers/theme_resolver.dart';

Builder themeBuilder(BuilderOptions options) {
  return JsonLibraryBuilder(
    ThemeResolver(),
    generatedExtension: '.theme.widgetbook.json',
    formatOutput: formatOutput,
  );
}

Builder storyBuilder(BuilderOptions options) {
  return JsonLibraryBuilder(
    StoryResolver(),
    generatedExtension: '.story.widgetbook.json',
    formatOutput: formatOutput,
  );
}

Builder widgetbookBuilder(BuilderOptions options) {
  return LibraryBuilder(
    WidgetbookGenerator(),
    generatedExtension: '.widgetbook.dart',
  );
}

String formatOutput(String input) {
  return input.replaceAll('\n]\n\n[\n', ',\n');
}
