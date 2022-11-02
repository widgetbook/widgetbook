import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';

import './command.dart';
import '../helpers/helpers.dart';
import '../models/models.dart';

typedef PackageList = List<Package>;

class SetupCommand extends WidgetbookCommand {
  SetupCommand({
    super.logger,
    FileSystem? fileSystem,
  }) : fileSystem = fileSystem ?? const LocalFileSystem();

  final FileSystem fileSystem;

  @override
  final String description = 'Set up widgetbook';

  @override
  final String name = 'setup';

  @override
  Future<int> run() async {
    final systemTempDir = fileSystem.currentDirectory;

    final projectName = systemTempDir.basename;

    final publishProgress = logger.progress(
      'Analyzing $projectName',
    );

    final projects = await _analyzeProject(systemTempDir);
    publishProgress.complete('Analyzing Project done');

    logger.success('Project Name : '
        '$projectName');

    final flutterProjectList = projects
        .where((package) => package.type == PackageType.flutterPackage)
        .toList();

    final dartPackageList = projects
        .where((package) => package.type == PackageType.dartPackage)
        .toList();

    for (final project in flutterProjectList) {
      dartPackageList.removeWhere(
        (package) => package.name == project.name,
      );
    }
    if (flutterProjectList.isNotEmpty) {
      logger.success(
        'Found ${flutterProjectList.length} Flutter Project(s)\n',
      );
    } else {
      logger.info('No Flutter Projects Found\n');
      _logDartPackages(dartPackageList);
      return ExitCode.noInput.code;
    }

    _logDartPackages(dartPackageList);

    final selectedProject = _selectProject(flutterProjectList);

    final projectPath =
        _getSelectedProjectPath(selectedProject, flutterProjectList);

    logger.success('Project path ; $projectPath');

    _getWidgetbookName();

    return ExitCode.success.code;
  }

  void _logDartPackages(PackageList dartPackageList) {
    if (dartPackageList.isNotEmpty) {
      logger.info('Found ${dartPackageList.length} other Dart Package(s) \n');
      for (final i in dartPackageList) {
        logger.info(i.name);
      }
      logger.info('\n');
    }
  }

  Future<PackageList> _analyzeProject(Directory systemTempDir) async {
    final projects = <Package>[];
    await for (final entity
        in systemTempDir.list(recursive: true, followLinks: false)) {
      if (entity.path.contains('pubspec.yaml')) {
        try {
          final isFlutterPackage = await PackageHelper().isFlutterPackage(
            fileSystem.directory(entity.path.replaceAll('pubspec.yaml', '')),
          );

          if (isFlutterPackage) {
            final project = Package(
              name: _getProjectName(entity.dirname),
              type: PackageType.flutterPackage,
              path: entity.path,
            );

            projects.add(project);
          }
        } catch (_) {}
      } else if (entity.path.contains('.dart_tool')) {
        if (entity.path.split('/').last == '.dart_tool') {
          final pack = Package(
            name: _getProjectName(entity.dirname),
            type: PackageType.dartPackage,
            path: entity.path,
          );

          projects.add(pack);
        }
      }
    }

    return projects;
  }

  String _getProjectName(String dirname) =>
      fileSystem.directory(dirname).basename;

  String _selectProject(PackageList flutterProjectList) {
    final selection = logger.chooseOne(
      'Select the project you would like to install widgetbook in',
      choices: flutterProjectList.map((e) => e.name).toList(),
    );

    return selection;
  }

  String _getWidgetbookName() {
    final preferedWidgetbookName = logger.prompt(
      'What would you like to call your widgetbook ? ',
    );
    return preferedWidgetbookName;
  }

  String _getSelectedProjectPath(
    String selectedProject,
    PackageList flutterProjects,
  ) {
    final projectPath = flutterProjects
        .firstWhere(
          (element) => element.name == selectedProject,
        )
        .path
        .replaceAll('pubspec.yaml', '');
    return projectPath;
  }
}
