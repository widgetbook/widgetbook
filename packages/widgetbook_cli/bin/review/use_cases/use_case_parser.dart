import 'dart:convert';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

import '../../helpers/modification.dart';
import '../../parsers/generator_parser.dart';
import 'models/changed_use_case.dart';
import 'models/use_case_data.dart';

class UseCaseParser extends GeneratorParser<ChangedUseCase> {
  UseCaseParser({
    required this.baseBranch,
    required super.projectPath,
    super.fileSystem = const LocalFileSystem(),
  });

  final String baseBranch;

  UseCaseData _getUseCase(dynamic data) {
    final stringData = json.encode(data);
    final correctData = json.decode(stringData) as Map<String, dynamic>;
    return UseCaseData.fromJson(correctData);
  }

  Iterable<UseCaseData> _getUseCasesFromFiles(List<File> files) sync* {
    for (final file in files) {
      final items = json.decode(
        file.readAsStringSync(),
      ) as Iterable<dynamic>;
      final useCases = List<UseCaseData>.from(
        items.map<UseCaseData>(
          _getUseCase,
        ),
      );

      yield* useCases;
    }
  }

  bool _hasChanged({
    required UseCaseData usecase,
    required FileDiff diff,
  }) {
    // TODO not sure if this works for mono-repos
    return _isMatch(
          usecasePath: usecase.componentDefinitionPath,
          diffPath: diff.refPath,
        ) ||
        _isMatch(
          usecasePath: usecase.useCaseDefinitionPath,
          diffPath: diff.refPath,
        ) ||
        _isMatch(
          usecasePath: usecase.componentDefinitionPath,
          diffPath: diff.basePath,
        ) ||
        _isMatch(
          usecasePath: usecase.useCaseDefinitionPath,
          diffPath: diff.basePath,
        );
  }

  bool _isMatch({
    required String usecasePath,
    required String? diffPath,
  }) {
    if (diffPath == null) {
      return false;
    } else {
      return usecasePath.endsWith(diffPath);
    }
  }

  @override
  Future<List<ChangedUseCase>> parse() async {
    // TODO we should be able to remove this
    if (fileSystem.isDirectorySync(generatedFolderPath)) {
      // TODO we should do this first
      if (!await GitDir.isGitDir(projectPath)) {
        return [];
      }

      final files =
          getFilesFromGeneratedFolder(fileExtension: '.usecase.widgetbook.json')
              .toList();

      // TODO use getItemsFromFiles instead!
      final useCases = _getUseCasesFromFiles(files).toList();

      final gitDir = await GitDir.fromExisting(
        projectPath,
        allowSubdirectory: true,
      );

      final fileDiffs = await gitDir.diff(
        base: baseBranch,
      );

      final changedUseCases = <ChangedUseCase>[];

      // TODO this is inefficient
      for (final useCase in useCases) {
        for (final diff in fileDiffs) {
          if (_hasChanged(usecase: useCase, diff: diff)) {
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

    return [];
  }
}
