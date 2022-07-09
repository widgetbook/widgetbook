import 'package:file/memory.dart';
import 'package:path/path.dart' as path;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../bin/parsers/generator_parser.dart';
import '../../../bin/review/text_scale_factors/models/text_scale_factor_data.dart';
import '../../../bin/review/text_scale_factors/text_scale_factor_parser.dart';

const content = '''
[
  {
    "value": 1.0
  },
  {
    "value": 2.0
  },
  {
    "value": 3.0
  }
]
''';

void main() {
  const projectPath = 'project';

  late MemoryFileSystem fileSystem;
  late TextScaleFactorParser parser;
  setUp(
    () {
      fileSystem = MemoryFileSystem();
      parser = TextScaleFactorParser(
        fileSystem: fileSystem,
        projectPath: projectPath,
      );
    },
  );

  group(
    '$TextScaleFactorParser',
    () {
      test(
        'parse() returns [1, 2, 3]',
        () async {
          // Setup
          fileSystem.file(
            path.join(
              projectPath,
              GeneratorParser.dartToolFolderName,
              GeneratorParser.buildFolderName,
              GeneratorParser.generatedFilesFolderName,
              'app.textscalefactors.widgetbook.json',
            ),
          )
            ..createSync(recursive: true)
            ..writeAsStringSync(content);

          // Test
          final result = await parser.parse();
          expect(
            result,
            equals(
              [
                TextScaleFactorData(value: 1),
                TextScaleFactorData(value: 2),
                TextScaleFactorData(value: 3),
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
              TextScaleFactorData(value: 1),
            ]),
          );
        },
      );
    },
  );
}
