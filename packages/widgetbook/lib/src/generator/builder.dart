import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'framework/components_builder.dart';
import 'framework/story_generator.dart';
import 'telemetry/telemetry_reporter.dart';

Builder storyBuilder(BuilderOptions options) {
  return PartBuilder(
    [StoryGenerator()],
    '.g.dart',
    header: header,
  );
}

Builder componentsBuilder(BuilderOptions options) {
  return ComponentsBuilder(
    header: header,
  );
}

/// Tracks some usage statistics to help us improve Widgetbook.
/// For more info: https://docs.widgetbook.io/telemetry
Builder reportTelemetry(BuilderOptions options) {
  return TelemetryReporter(
    isDebug: options.config['debug'] as bool? ?? false,
  );
}

String get header {
  const ignoredLintRules = {
    'unused_import',
    'prefer_relative_imports',
    'directives_ordering',
    'unused_element',
    'strict_raw_type',
  };

  final parts = [
    '$defaultFileHeader',
    '',
    '// coverage:ignore-file',
    '// ignore_for_file: type=lint',
    '// ignore_for_file: ${ignoredLintRules.join(", ")}',
  ];

  return parts.join('\n');
}
