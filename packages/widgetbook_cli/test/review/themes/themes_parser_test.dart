import 'package:file/memory.dart';
import 'package:path/path.dart' as path;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../bin/parsers/generator_parser.dart';
import '../../../bin/review/themes/models/theme_data.dart';
import '../../../bin/review/themes/theme_parser.dart';

const themeName1 = 'Default';
const themeContent1 = '''
[
  {
    "name": "theme",
    "importStatement": "package:widgetbook_comparison_demo/main.dart",
    "dependencies": [
      "dart:core",
      "package:widgetbook_annotation/widgetbook_annotation.dart",
      "package:flutter/material.dart"
    ],
    "isDefault": false,
    "themeName": "$themeName1"
  }
]
''';

void main() {
  const projectPath = 'project';

  late MemoryFileSystem fileSystem;
  late ThemeParser parser;
  setUp(
    () {
      fileSystem = MemoryFileSystem();
      parser = ThemeParser(
        fileSystem: fileSystem,
        projectPath: projectPath,
      );
    },
  );

  group(
    '$ThemeParser',
    () {
      test(
        'parse() returns Theme',
        () async {
          // Setup
          fileSystem.file(
            path.join(
              projectPath,
              GeneratorParser.dartToolFolderName,
              GeneratorParser.buildFolderName,
              GeneratorParser.generatedFilesFolderName,
              'app.theme.widgetbook.json',
            ),
          )
            ..createSync(recursive: true)
            ..writeAsStringSync(themeContent1);

          // Test
          final result = await parser.parse();
          expect(
            result,
            equals(
              [
                ThemeData(name: themeName1),
              ],
            ),
          );
        },
      );

      test(
        'parse() returns []',
        () async {
          // Setup
          // No file

          // Test
          final result = await parser.parse();
          expect(
            result,
            isEmpty,
          );
        },
      );
    },
  );
}
