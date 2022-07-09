import 'package:file/local.dart';

import '../../parsers/generator_parser.dart';
import 'models/device_data.dart';

class DeviceParser extends GeneratorParser<DeviceData> {
  DeviceParser({
    required super.projectPath,
    super.fileSystem = const LocalFileSystem(),
  });

  @override
  Future<List<DeviceData>> parse() async {
    final files = getFilesFromGeneratedFolder(
      fileExtension: '.devices.widgetbook.json',
    );
    final devices = getItemsFromFiles(
      files,
      fromJson: DeviceData.fromJson,
    ).toList();

    if (devices.isNotEmpty) {
      return devices;
    }

    // TODO this is really bad if we update this in widgetbook package
    return [
      DeviceData(name: 'iPhone 12'),
      DeviceData(name: 'iPhone 13'),
    ];
  }
}
