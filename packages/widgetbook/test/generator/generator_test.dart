// Golden tests for the [StoryGenerator].
//
// Each fixture `{name}/{name}.stories.dart` is run through the generator and
// the output is compared against `{name}/{name}.stories.g.dart`. All fixtures
// are resolved by a single analyzer instance, as starting one per fixture
// dominates the runtime. To add a fixture, create its directory and register
// it in [fixtures].
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

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:dart_style/dart_style.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_config/package_config.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'package:widgetbook/src/generator/framework/story_generator.dart';

const fixtures = {
  'custom_args': 'generates required builder when using a custom args type',
  'default_values': 'generates args with explicit default values',
  'doc_comment':
      'generates correct docComment for doc comments with empty lines',
  'doc_comment_code':
      'generates correct docComment for doc comments with code containing '
      r'$ signs',
  'enums': 'generates EnumArg for enum parameters',
  'generic': 'propagates generic type parameters through generated classes',
  'generic_bound': 'preserves type arguments on generic bounds',
  'generic_bound_dynamic': 'preserves dynamic type arguments on generic bounds',
  'generic_bound_nullable':
      'preserves nullable type arguments on generic bounds',
  'multi_constructor':
      'resolves constructor variants by tear-off regardless of declaration '
      'order',
  'nullable': 'generates nullable Arg fields for nullable params',
  'primitive': 'generates Story and Args classes for primitive types',
  'static_methods': 'generates args with static method default values',
  'variants': 'generates prefixed types per constructor variant',
  'with_defaults': 'pipes defaults.setup and defaults.builder into Story',
};

class _MockBuildStep extends Mock implements BuildStep {}

final _updateGoldens = Platform.environment['UPDATE_GOLDENS'] == 'true';

final _formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

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
