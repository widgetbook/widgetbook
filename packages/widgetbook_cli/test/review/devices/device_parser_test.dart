import 'package:file/memory.dart';
import 'package:path/path.dart' as path;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../bin/parsers/generator_parser.dart';
import '../../../bin/review/devices/device_parser.dart';
import '../../../bin/review/devices/models/device_data.dart';

const device1 = 'iPhone 12';
const device2 = 'iPhone 12 Pro';
const deviceContent = '''
[
  {
    "name": "$device1"
  },
  {
    "name": "$device2"
  }
]
''';

void main() {
  const projectPath = 'project';

  late MemoryFileSystem fileSystem;
  late DeviceParser parser;
  setUp(
    () {
      fileSystem = MemoryFileSystem();
      parser = DeviceParser(
        fileSystem: fileSystem,
        projectPath: projectPath,
      );
    },
  );

  group(
    '$DeviceParser',
    () {
      test(
        'parse() returns Devices',
        () async {
          // Setup
          fileSystem.file(
            path.join(
              projectPath,
              GeneratorParser.dartToolFolderName,
              GeneratorParser.buildFolderName,
              GeneratorParser.generatedFilesFolderName,
              // TODO we should put this extension as a const in the class so we
              // can access it here and simplify the whole testing environment
              'app.devices.widgetbook.json',
            ),
          )
            ..createSync(recursive: true)
            ..writeAsStringSync(deviceContent);

          // Test
          final result = await parser.parse();
          expect(
            result,
            equals(
              [
                DeviceData(name: device1),
                DeviceData(name: device2),
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
            equals(
              [
                DeviceData(name: 'iPhone 12'),
                DeviceData(name: 'iPhone 13'),
              ],
            ),
          );
        },
      );
    },
  );
}
