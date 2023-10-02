import 'dart:convert';

import 'package:file/file.dart';
import 'package:path/path.dart';

import '../git/file_diff.dart';
import 'changed_use_case.dart';
import 'use_case_metadata.dart';

class UseCaseReader {
  const UseCaseReader({
    required this.fileSystem,
  });

  final FileSystem fileSystem;

  Future<List<UseCaseMetadata>> read(String path) async {
    final generatedDir = join(path, '.dart_tool', 'build', 'generated');
    final generatedDirExist = await fileSystem.isDirectory(generatedDir);

    if (!generatedDirExist) {
      return [];
    }

    final files = await fileSystem
        .directory(generatedDir)
        .list(recursive: true)
        .takeWhile((entity) => entity.path.endsWith('.usecase.widgetbook.json'))
        .cast<File>();

    return files
        .asyncMap((file) => file.readAsString())
        .map((json) => jsonDecode(json) as List)
        .map((list) => list.cast<Map<String, dynamic>>())
        .expand((list) => list) // Flatten JSON List
        .map((item) => UseCaseMetadata.fromJson(item))
        .toList();
  }

  List<ChangedUseCase> compare({
    required List<UseCaseMetadata> useCases,
    required List<FileDiff> diffs,
  }) {
    final changedUseCases = <ChangedUseCase>[];

    for (final useCase in useCases) {
      for (final diff in diffs) {
        final hasChanged = _hasChanged(
          useCase: useCase,
          diff: diff,
        );

        if (hasChanged) {
          changedUseCases.add(
            ChangedUseCase(
              name: useCase.useCaseName,
              componentName: useCase.componentName,
              componentDefinitionPath: useCase.componentDefinitionPath,
              // TODO works for now, but on a file level we can't really say
              // if a single use-case was added or not
              // for this, we require AT LEAST line-diff functionality
              modification: diff.modification,
              designLink: useCase.designLink,
            ),
          );
          break;
        }
      }
    }

    return changedUseCases;
  }

  bool _hasChanged({
    required UseCaseMetadata useCase,
    required FileDiff diff,
  }) {
    if (diff.refPath == null || diff.basePath == null) {
      return false;
    }

    return _comparePaths(useCase.componentDefinitionPath, diff.refPath!) ||
        _comparePaths(useCase.useCaseDefinitionPath, diff.refPath!) ||
        _comparePaths(useCase.componentDefinitionPath, diff.basePath!) ||
        _comparePaths(useCase.useCaseDefinitionPath, diff.basePath!);
  }

  /// Returns true if [a] and [b] are equal or
  /// if one of them is a sub-path of the other.
  bool _comparePaths(String a, String b) {
    return a == b || a.endsWith(b) || b.endsWith(a);
  }
}
