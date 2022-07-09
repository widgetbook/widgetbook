import 'package:file/memory.dart';
import 'package:test/test.dart';

import '../../bin/parsers/generator_parser.dart';

class TestGenerator extends GeneratorParser<dynamic> {
  TestGenerator({
    required super.projectPath,
    required super.fileSystem,
  });

  @override
  Future<List> parse() {
    throw UnimplementedError();
  }
}

void main() {
  late TestGenerator generator;

  const projectPath = 'projectPath';

  setUp(
    () {
      generator = TestGenerator(
        projectPath: projectPath,
        fileSystem: MemoryFileSystem(),
      );
    },
  );

  group(
    '$GeneratorParser',
    () {
      test(
        'generatedFolderPath returns correct path',
        () {
          expect(
            generator.generatedFolderPath,
            equals('$projectPath/.dart_tool/build/generated'),
          );
        },
      );
    },
  );
}
