import 'dart:convert';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart';

import '../models/models.dart';

class UseCaseReader {
  const UseCaseReader({
    this.fileSystem = const LocalFileSystem(),
  });

  final FileSystem fileSystem;

  Future<List<UseCaseMetadata>> read(String path) async {
    final generatedDir = join(path, '.dart_tool', 'build', 'generated');
    final generatedDirExist = await fileSystem.isDirectory(generatedDir);

    if (!generatedDirExist) {
      return [];
    }

    final files = fileSystem
        .directory(generatedDir)
        .list(recursive: true)
        .where((entity) => entity.path.endsWith('.usecase.widgetbook.json'))
        .cast<File>();

    return files
        .asyncMap((file) => file.readAsString())
        .map((json) => jsonDecode(json) as List)
        .map((list) => list.cast<Map<String, dynamic>>())
        .expand((list) => list) // Flatten JSON List
        .map((item) => UseCaseMetadata.fromJson(item))
        .toList();
  }
}
