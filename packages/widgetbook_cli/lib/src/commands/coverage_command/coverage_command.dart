// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'cli_exception.dart';

part 'get_project_widgetbook_usecases.dart';
part 'get_project_widgets.dart';
part 'models.dart';
part 'time_logger.dart';
part 'widget_visitor.dart';
part 'widgetbook_use_case_visitor.dart';

///TODO: bug can currently have a different flutter project and widgetbook project

////TODO: Feature ideas:
/// POLISH:    - Allow user to exclude private widgets
/// ESSENTIAL: - add strict flag to fail if there are any uncovered widgets
/// - Allow options, flags to be set in a widgetbook_coverage yaml file
/// - Allow user to ignore certain files, folders
/// - Add a lcov coverage file
/// - Allow user to specify the output file for the coverage report
/// - cache the initial analyzer context for future runs
///   - For example we know that ConsumerWidget, so we can cache that and not reanalyze it for subsequent runs
///   - So what we need to do is to cache the superclasses of unknown widget types ConsumerWidget etc and
///     reuse them for subsequent runs so we dont need to reload the analyzer for them. And maybe we only use the
///     analyzer for new uknown widget types that might pop up.

class CoverageCommand extends Command<int> {
  CoverageCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'flutter_project',
        help:
            'Target path for analyzer context of the Flutter project, defaults to the current directory if not specified.',
      )
      ..addOption(
        'widgetbook_project',
        help:
            'Target path for analyzer context of the widgetbook project, defaults to the current directory if not specified.',
      )
      ..addOption(
        'widgets_target',
        help:
            'Target path for the widgets folder, defaults to  <flutter_project>/lib if not specified.',
      )
      ..addOption(
        'widgetbook_usecases_target',
        help:
            'Target path for the widgetbook usecases folder, defaults to  <widgetbook_project>/lib if not specified.',
      );
  }

  @override
  String get description =>
      'A command that checks for widgetbook coverage in a project.';

  @override
  String get name => 'coverage';

  final Logger _logger;

  late final TimeLogger _timeLogger = TimeLogger(_logger);

  String? _flutterProjectName;
  String get flutterProjectName {
    _flutterProjectName ??= File('$flutterProject/pubspec.yaml')
        .readAsStringSync()
        .split('\n')
        .firstWhere((line) => line.contains('name:'))
        .split(':')
        .last
        .trim()
        .replaceAll(RegExp(r'''^[\'"]|[\'"]$'''), '');

    return _flutterProjectName!;
  }

  /* --------------------------------- Options -------------------------------- */
  /// The target path used by the analyzer to include the context to output
  /// The widgets in the project and their dependencies.
  String get flutterProject =>
      argResults?['flutter_project'] as String? ?? Directory.current.path;

  /// The option used by the analyzer to include enough context to output
  /// the widgets included in widgetbook.
  String get widgetbookProject =>
      argResults?['widgetbook_project'] as String? ?? Directory.current.path;

  /// The target path for the widgets folder we wish to check for coverage.
  String get widgetsTarget =>
      argResults?['widgets_target'] as String? ?? '$flutterProject/lib';

  /// The target path for the widgetbook folder we wish to check for coverage.
  String get widgetbookUsecasesTarget =>
      argResults?['widgetbook_usecases_target'] as String? ??
      '$widgetbookProject/lib';
  /* --------------------------------- Options -------------------------------- */

  @override
  Future<int> run() async {
    try {
      /* ---------------------- validity checks of the input ---------------------- */
      _timeLogger.start('Validating input directories...');
      if (!_isValidDirectoryInputs()) {
        return ExitCode.usage.code;
      }

      if (!_isFlutterProject() || !_isValidWidgetbookProject()) {
        return ExitCode.usage.code;
      }
      _timeLogger.stop('Finished validating input directories.');
      /* ---------------------- validity checks of the input ---------------------- */

      /* ------------- get file paths to be evaluated by the analyzer ------------- */
      _timeLogger.start('Loading widget and widgetbook target file paths...');
      final widgetPaths = _getFilePaths(widgetsTarget);
      final widgetbookPaths = widgetsTarget == widgetbookUsecasesTarget
          ? widgetPaths
          : _getFilePaths(widgetbookUsecasesTarget);
      _timeLogger
          .stop('Finished loading widget and widgetbook target file paths.');
      /* ------------- get file paths to be evaluated by the analyzer ------------ */

      /* ------------------------ get widgets and usecases ------------------------ */
      final futures = await Future.wait([
        _getProjectWidgets(
          PathData(
            filePaths: widgetPaths,
            projectRootPath: flutterProject,
          ),
          _logger,
        ),
        _getProjectWidgetbookUseCases(
          PathData(
            filePaths: widgetbookPaths,
            projectRootPath: widgetbookProject,
          ),
          _logger,
        ),
      ]);

      final widgets = futures.first;
      final usecases = futures.last;
      final uncoveredWidgets = <String>[];
      /* ------------------------ get widgets and usecases ------------------------ */

      /* ---------------------- compare widgets and usecases ---------------------- */
      for (var widget in widgets) {
        if (!usecases.contains(widget)) {
          uncoveredWidgets.add(widget);
        }
      }

      _logger.info('Currently Uncovered widgets: ${uncoveredWidgets.length} \n '
          'Uncovered widgets: ${uncoveredWidgets.join(', ')}');
      /* ---------------------- compare widgets and usecases ---------------------- */

      return ExitCode.success.code;
    } on CliException catch (e) {
      //display message but remove any new lines
      _logger.err(e.message
          .replaceAll('\n', '')
          .trim()
          .replaceAll(RegExp(r'\s+'), ' '));

      return e.exitCode;
    } catch (e) {
      _logger.err(e.toString());
      return ExitCode.software.code;
    }
  }

  /// gets all the absolute file paths in a directory path.
  List<String> _getFilePaths(String directoryPath) {
    final dartFiles = Directory(directoryPath)
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .map((file) => file.absolute.path)
        .toList();

    if (dartFiles.isEmpty) {
      throw CliException(
        '''
        Cannot find dart files in $directoryPath and 
        therefore cannot be set as a widgets_target
        ''',
        ExitCode.ioError.code,
      );
    }
    return dartFiles;
  }

  /// Checks if the [flutterProject] directory is a Flutter project root directory.
  /// By checking for the presence of a pubspec.yaml file
  /// and Flutter dependency in the pubspec.yaml file.
  bool _isFlutterProject() {
    final pubspecFile = File('$flutterProject/pubspec.yaml').absolute;

    // Check if pubspec.yaml exists
    if (!pubspecFile.existsSync()) {
      throw CliException(
        '''
        Cannot find a pubspec.yaml file for $flutterProject, 
        the coverage command can only run from a Flutter project root directory.
        ''',
        ExitCode.usage.code,
      );
    }

    // Read the contents of pubspec.yaml
    final pubspecContent = pubspecFile.readAsStringSync();

    // Check for the presence of 'flutter' in the pubspec.yaml file
    if (!pubspecContent.contains('flutter:')) {
      throw CliException(
        '''
        Cannot find Flutter dependency in pubspec.yaml file, the coverage 
        command can only run from a Flutter project root directory.
        ''',
        ExitCode.usage.code,
      );
    }

    if (!widgetsTarget.contains(flutterProject)) {
      throw CliException(
        '''
        The flutter_project and widgets_target options should point to the
        same project. The flutter_project project is $flutterProject and
        the widgets_target project is $widgetsTarget.
        ''',
        ExitCode.usage.code,
      );
    }

    return true;
  }

  /// Checks if the [widgetbookProject] directory is a valid widgetbook project.
  /// By checking for the presence of a pubspec.yaml file
  /// and widgetbook dependency in the pubspec.yaml file.
  /// If the [widgetbookProject] is different from the [flutterProject],
  /// it checks if the widgetbook project imports the flutter project in the
  /// [flutterProject] directory.
  bool _isValidWidgetbookProject() {
    final pubspecFile = File('$widgetbookProject/pubspec.yaml');

    // Check if pubspec.yaml exists
    if (!pubspecFile.existsSync()) {
      throw CliException(
        '''
        Cannot find a pubspec.yaml file for $widgetbookProject, 
        the coverage command can only run from a Flutter project root directory.
        ''',
        ExitCode.usage.code,
      );
    }

    // Read the contents of pubspec.yaml
    final pubspecContent = pubspecFile.readAsStringSync();

    // Check for the presence of 'widgetbook' in the pubspec.yaml file
    if (!pubspecContent.contains('widgetbook:')) {
      throw CliException(
        '''
        Cannot find widgetbook dependency in pubspec.yaml file, the coverage 
        command can only run from a Flutter project containing a widgetbook
        dependency. Specify the widgetbook_project option to a project
        containing a widgetbook dependency.
        ''',
        ExitCode.usage.code,
      );
    }

    // if widgetbook context is a different project, check if the widgetbook
    // project imports the flutter project
    if (widgetbookProject != flutterProject) {
      if (!pubspecContent.contains('$flutterProjectName:')) {
        throw CliException(
          '''
          The widgetbook project in $widgetbookProject does not depend on the
          Flutter project $flutterProjectName. widgetbook_project
          should point to the widgetbook project related to the Flutter project
          in flutter_project $flutterProject. 
          ''',
          ExitCode.usage.code,
        );
      }
    }

    if (!widgetbookUsecasesTarget.contains(widgetbookProject)) {
      throw CliException(
        '''
        The widgetbook_project and widgetbook_usecases_target options should point to the
        same project, the widgetbook_project project is $widgetbookProject and
        and the widgetbook_usecases_target project is $widgetbookUsecasesTarget.
        ''',
        ExitCode.usage.code,
      );
    }

    return true;
  }

  bool _isValidDirectoryInputs() =>
      _isValidDirectory(
        flutterProject,
        option: 'flutter_project',
      ) &&
      _isValidDirectory(
        widgetbookProject,
        option: 'widgetbook_project',
      ) &&
      _isValidDirectory(
        widgetsTarget,
        option: 'widgets_target',
      ) &&
      _isValidDirectory(
        widgetbookUsecasesTarget,
        option: 'widgetbook_usecases_target',
      );

  /// Checks if the provided path is a valid directory.
  bool _isValidDirectory(
    String path, {
    required String option,
  }) {
    final directory = Directory(path);

    if (path.isEmpty) {
      throw CliException(
        'Empty path argument is invalid for $option.',
        ExitCode.usage.code,
      );
    }

    if (directory.statSync().type != FileSystemEntityType.directory) {
      throw CliException(
        '$path is not a directory for $option.',
        ExitCode.ioError.code,
      );
    }

    if (!directory.existsSync()) {
      throw CliException(
        'Directory $path not found for $option.',
        ExitCode.ioError.code,
      );
    }

    if (directory.listSync().isEmpty) {
      throw CliException(
        'Empty directory $path cannot be set as target for coverage for $option.',
        ExitCode.ioError.code,
      );
    }

    return true;
  }
}
