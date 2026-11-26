// Golden tests for the [StoryGenerator].
//
// Each fixture `{name}/{name}.stories.dart` is run through the generator and
// the output is compared against `{name}/{name}.stories.g.dart`. All fixtures
// are resolved by a single analyzer instance, as starting one per fixture
// dominates the runtime. To add a fixture, create
// `{name}/{name}.stories.dart` with a top-level `description` string constant
// and generate its golden.
//
// Set `UPDATE_GOLDENS=true` to overwrite the golden files with the current
// generator output:
//
// ```sh
// UPDATE_GOLDENS=true dart test test/generator/ --platform vm
// ```
//
// These tests require `dart test --platform vm` because `build_test` uses
// `Isolate.packageConfig`, which is not available in `flutter test`. When run
// under `flutter test`, the tests are skipped.

@TestOn('vm')
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:dart_style/dart_style.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_config/package_config.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'package:widgetbook/src/generator/framework/story_generator.dart';

/// Fixture name -> description, discovered from `{name}/{name}.stories.dart`.
final fixtures = _discoverFixtures();

class _MockBuildStep extends Mock implements BuildStep {}

final _updateGoldens = Platform.environment['UPDATE_GOLDENS'] == 'true';

final _formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

Map<String, String> _discoverFixtures() {
  final files =
      Directory('test/generator')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.stories.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  return {
    for (final file in files)
      file.uri.pathSegments.last.replaceFirst('.stories.dart', ''):
          _readDescription(file),
  };
}

/// Reads the `description` constant syntactically, as the fixtures depend on
/// Flutter and cannot be imported here.
String _readDescription(File file) {
  final unit = parseString(content: file.readAsStringSync()).unit;
  final initializer = unit.declarations
      .whereType<TopLevelVariableDeclaration>()
      .expand((declaration) => declaration.variables.variables)
      .where((variable) => variable.name.lexeme == 'description')
      .map((variable) => variable.initializer)
      .firstOrNull;

  if (initializer case StringLiteral(:final stringValue?)) {
    return stringValue;
  }

  throw StateError(
    '${file.path} must declare a top-level `description` string constant.',
  );
}

AssetId _inputId(String name) => AssetId('_test_pkg', 'lib/$name.stories.dart');

/// Runs the [StoryGenerator] on all [fixtures] using a single resolver,
/// returning the raw generator output per fixture name.
Future<Map<String, String>> _generateAll() async {
  final packageConfig = (await findPackageConfig(Directory.current))!;
  final sources = {
    for (final name in fixtures.keys)
      _inputId(name).toString(): File(
        'test/generator/$name/$name.stories.dart',
      ).readAsStringSync(),
  };

  return resolveSources(
    sources,
    (resolver) async {
      final generator = StoryGenerator();
      final outputs = <String, String>{};
      for (final name in fixtures.keys) {
        final inputId = _inputId(name);
        final library = await resolver.libraryFor(inputId);
        final buildStep = _MockBuildStep();
        when(() => buildStep.inputId).thenReturn(inputId);
        outputs[name] = await generator.generate(
          LibraryReader(library),
          buildStep,
        );
      }
      return outputs;
    },
    packageConfig: packageConfig,
    readAllSourcesFromFilesystem: true,
  );
}

/// Builds the full `.g.dart` file content from the raw generator output,
/// matching the format that `source_gen`'s `PartBuilder` produces.
String _buildGoldenContent(String name, String generatorOutput) {
  final raw =
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of '$name.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

$generatorOutput
''';
  return _formatter.format(raw);
}

void main() {
  late final Map<String, String> outputs;
  String? skipReason;

  setUpAll(() async {
    try {
      outputs = await _generateAll();
    } on UnsupportedError catch (e) {
      if (!'$e'.contains('packageConfig')) rethrow;
      skipReason =
          'Requires dart test --platform vm '
          '(Isolate.packageConfig not available in flutter test)';
    }
  });

  for (final MapEntry(key: name, value: description) in fixtures.entries) {
    test('$name: $description', () {
      if (skipReason != null) {
        markTestSkipped(skipReason!);
        return;
      }

      final actual = _buildGoldenContent(name, outputs[name]!);
      final goldenFile = File('test/generator/$name/$name.stories.g.dart');

      if (_updateGoldens) {
        goldenFile.writeAsStringSync(actual);
        return;
      }

      expect(
        goldenFile.existsSync(),
        isTrue,
        reason:
            'Golden file not found: ${goldenFile.path}\n'
            'Run with UPDATE_GOLDENS=true to create it.',
      );

      expect(actual, equals(goldenFile.readAsStringSync()));
    });
  }
}
