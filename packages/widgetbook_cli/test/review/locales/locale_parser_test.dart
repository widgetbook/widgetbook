import 'package:file/memory.dart';
import 'package:path/path.dart' as path;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../bin/parsers/generator_parser.dart';
import '../../../bin/review/locales/locales_parser.dart';
import '../../../bin/review/locales/models/locale_data.dart';

const localeName1 = 'en';
const localeName2 = 'de';
const themeContent1 = '''
[
  {
    "name": "locales",
    "importStatement": "package:widgetbook_comparison_demo/main.dart",
    "dependencies": [],
    "locales": [
      "$localeName1",
      "$localeName2"
    ]
  }
]

''';

void main() {
  const projectPath = 'project';

  late MemoryFileSystem fileSystem;
  late LocaleParser parser;
  setUp(
    () {
      fileSystem = MemoryFileSystem();
      parser = LocaleParser(
        fileSystem: fileSystem,
        projectPath: projectPath,
      );
    },
  );

  group(
    '$LocaleParser',
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
              'app.locales.widgetbook.json',
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
                LocaleData(name: localeName1),
                LocaleData(name: localeName2),
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
            equals([
              LocaleData(name: 'en'),
            ]),
          );
        },
      );
    },
  );
}
