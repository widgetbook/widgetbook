import 'dart:convert';

import 'package:file/file.dart';
import 'package:path/path.dart' as path;

abstract class GeneratorParser<T> {
  GeneratorParser({
    required this.projectPath,
    required this.fileSystem,
  });
  static const dartToolFolderName = '.dart_tool';
  static const buildFolderName = 'build';
  static const generatedFilesFolderName = 'generated';

  final FileSystem fileSystem;
  final String projectPath;

  String get dartToolPath => path.join(
        projectPath,
        dartToolFolderName,
      );
  String get buildPath => path.join(
        dartToolPath,
        buildFolderName,
      );
  String get generatedFolderPath => path.join(
        buildPath,
        generatedFilesFolderName,
      );

  bool get doesGeneratedFilesFolderExist =>
      fileSystem.isDirectorySync(generatedFolderPath);

  Iterable<ItemType> getItemsFromFiles<ItemType>(
    Iterable<File> files, {
    required ItemType Function(Map<String, dynamic>) fromJson,
  }) sync* {
    for (final file in files) {
      final items = json.decode(
        file.readAsStringSync(),
      ) as Iterable;

      for (final item in items) {
        // We do this because json decode has a weird implementation which
        // causes fromJson method to fail otherwise.
        final stringData = json.encode(item);
        final correctData = json.decode(stringData) as Map<String, dynamic>;
        yield fromJson(correctData);
      }
    }
  }

  /// Returns all files from the generated folder which end with the
  /// [fileExtension].
  Iterable<File> getFilesFromGeneratedFolder({
    required String fileExtension,
  }) sync* {
    if (doesGeneratedFilesFolderExist) {
      yield* fileSystem
          .directory(generatedFolderPath)
          .listSync(recursive: true)
          .whereType<File>()
          .where((File file) => file.path.endsWith(fileExtension));
    }
  }

  Future<List<T>> parse();
}
