import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:dart_style/dart_style.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_config/package_config.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'package:widgetbook/src/generator/framework/story_generator.dart';

export 'package:test/test.dart';

class _MockBuildStep extends Mock implements BuildStep {}

PackageConfig? _cachedPackageConfig;

final _updateGoldens = Platform.environment['UPDATE_GOLDENS'] == 'true';

final _formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

Future<PackageConfig> _loadPackageConfig() async {
  return _cachedPackageConfig ??=
      (await findPackageConfig(Directory.current))!;
}

/// Builds the full `.g.dart` file content from the raw generator output,
/// matching the format that `source_gen`'s `PartBuilder` produces.
String _buildGoldenContent(String name, String generatorOutput) {
  final raw = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of '$name.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

$generatorOutput
''';
  return _formatter.format(raw);
}

/// Runs the [StoryGenerator] on `test/generator/{name}/{name}.stories.dart`
/// and compares the output against `test/generator/{name}/{name}.stories.g.dart`.
///
/// Set `UPDATE_GOLDENS=true` to overwrite the golden files with the current
/// generator output:
///
/// ```sh
/// UPDATE_GOLDENS=true dart test test/generator/ --platform vm
/// ```
///
/// These tests require `dart test --platform vm` because `build_test`
/// uses `Isolate.packageConfig` which is not available in `flutter test`.
/// When run under `flutter test`, the test is automatically skipped.
Future<void> testStoryGenerator(String name) async {
  final dir = 'test/generator/$name';
  final source = File('$dir/$name.stories.dart').readAsStringSync();
  final inputId = AssetId('_test_pkg', 'lib/$name.stories.dart');
  final packageConfig = await _loadPackageConfig();

  late final String generatorOutput;
  try {
    generatorOutput = await resolveSource(
      source,
      (resolver) async {
        final library = await resolver.libraryFor(inputId);
        final reader = LibraryReader(library);

        final buildStep = _MockBuildStep();
        when(() => buildStep.inputId).thenReturn(inputId);

        final generator = StoryGenerator();
        return generator.generate(reader, buildStep);
      },
      inputId: inputId,
      packageConfig: packageConfig,
      readAllSourcesFromFilesystem: true,
    );
  } on UnsupportedError catch (e) {
    if ('$e'.contains('packageConfig')) {
      markTestSkipped(
        'Requires dart test --platform vm '
        '(Isolate.packageConfig not available in flutter test)',
      );
      return;
    }
    rethrow;
  }

  final actual = _buildGoldenContent(name, generatorOutput);
  final goldenFile = File('$dir/$name.stories.g.dart');

  if (_updateGoldens) {
    goldenFile.writeAsStringSync(actual);
    return;
  }

  expect(
    goldenFile.existsSync(),
    isTrue,
    reason: 'Golden file not found: ${goldenFile.path}\n'
        'Run with UPDATE_GOLDENS=true to create it.',
  );

  expect(actual, equals(goldenFile.readAsStringSync()));
}
