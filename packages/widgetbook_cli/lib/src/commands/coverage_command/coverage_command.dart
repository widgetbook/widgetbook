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
import '../../../widgetbook_cli.dart';

part 'get_project_widgetbook_usecases.dart';
part 'get_project_widgets.dart';
part 'models.dart';
part 'time_logger.dart';
part 'widget_visitor.dart';
part 'widgetbook_use_case_visitor.dart';

class CoverageCommand extends Command<int> {
  CoverageCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'package',
        help: '(required) Target path of the Flutter package.',
      )
      ..addOption(
        'widgetbook',
        help: '(required) Target path of the widgetbook package.',
      )
      ..addOption(
        'widgets_target',
        help:
            'Target path for the root widgets folder, defaults to  <package>/lib if not specified.',
      )
      ..addOption(
        'widgetbook_usecases_target',
        help:
            'Target path for the root widgetbook usecases folder, defaults to  <widgetbook>/lib if not specified.',
      )
      ..addFlag(
        'verbose',
        help: 'Prints out verbose output for debugging purposes.',
      );
  }

  @override
  String get description =>
      'A command that checks for widgetbook coverage in a package.';

  @override
  String get name => 'coverage';

  final Logger _logger;

  late final TimeLogger _timeLogger = TimeLogger(_logger);

  String? _packageName;
  String get packageName {
    _packageName ??= File('$package/pubspec.yaml')
        .readAsStringSync()
        .split('\n')
        .firstWhere((line) => line.contains('name:'))
        .split(':')
        .last
        .trim()
        .replaceAll(RegExp(r'''^[\'"]|[\'"]$'''), '');

    return _packageName!;
  }

  /* --------------------------------- Options -------------------------------- */
  /// The target path used by the analyzer to include the context to output
  /// The widgets in the project and their dependencies.
  String get package {
    if (argResults?['package'] == null) {
      throw FolderNotFoundException(
        message:
            'Package path not found, please provide a valid package path using the "--package" option.',
      );
    }

    if (argResults?['package'] == '.') return Directory.current.path;
    if (argResults?['package'] == '..') return Directory.current.parent.path;
    return Directory(argResults!['package'] as String).absolute.path;
  }

  /// The option used by the analyzer to include enough context to output
  /// the widgets included in widgetbook.
  String get widgetbook {
    if (argResults?['widgetbook'] == null) {
      throw FolderNotFoundException(
        message:
            'Widgetbook path not found, please provide a valid widgetbook path using the "--widgetbook" option.',
      );
    }

    if (argResults?['widgetbook'] == '.') return Directory.current.path;
    if (argResults?['widgetbook'] == '..') return Directory.current.parent.path;
    return Directory(argResults!['widgetbook'] as String).absolute.path;
  }

  /// The target path for the widgets folder we wish to check for coverage.
  String get widgetsTarget =>
      argResults?['widgets_target'] as String? ?? '$package/lib';

  /// The target path for the widgetbook folder we wish to check for coverage.
  String get widgetbookUsecasesTarget =>
      argResults?['widgetbook_usecases_target'] as String? ?? '$widgetbook/lib';
  /* --------------------------------- Options -------------------------------- */

  /* ---------------------------------- Flags --------------------------------- */
  bool get verbose => argResults!['verbose'] as bool;
  /* ---------------------------------- Flags --------------------------------- */

  @override
  Future<int> run() async {
    if (verbose) {
      _logger.info('package: $package');
      _logger.info('widgetbook: $widgetbook');
      _logger.info('widgets_target: $widgetsTarget');
      _logger.info('widgetbook_usecases_target: $widgetbookUsecasesTarget');
    }

    /* ---------------------- validity checks of the input ---------------------- */
    _timeLogger.start('Validating input directories...');
    if (!_isValidDirectoryInputs()) {
      return ExitCode.usage.code;
    }

    if (!_isPackage() || !_isValidWidgetbook()) {
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
          projectRootPath: package,
        ),
        _logger,
      ),
      _getProjectWidgetbookUseCases(
        PathData(
          filePaths: widgetbookPaths,
          projectRootPath: widgetbook,
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
      throw FileNotFoundException(
        message:
            'Dart files not found for --widgets_target option $directoryPath',
      );
    }
    return dartFiles;
  }

  /// Checks if the [package] directory is a Flutter project root directory.
  /// By checking for the presence of a pubspec.yaml file
  /// and Flutter dependency in the pubspec.yaml file.
  /// Checks also that widgets_target and package are the same project.
  bool _isPackage() {
    final pubspecFile = File('$package/pubspec.yaml').absolute;

    // Check if pubspec.yaml exists
    if (!pubspecFile.existsSync()) {
      throw InvalidFlutterPackageException(
        message:
            'pubspec.yaml file is missing for --package option $package, please provide a valid Flutter project root directory.',
      );
    }

    // Read the contents of pubspec.yaml
    final pubspecContent = pubspecFile.readAsStringSync();

    // Check for the presence of 'flutter' in the pubspec.yaml file
    if (!pubspecContent.contains('flutter:')) {
      throw InvalidFlutterPackageException(
        message:
            'Flutter dependency is missing for --package option $package, please provide a valid Flutter project root directory.',
      );
    }

    if (!widgetsTarget.contains(package)) {
      throw InvalidFlutterPackageException(
        message:
            'The package and widgets_target options should point to the same project. The package project is $package and the widgets_target project is $widgetsTarget.',
      );
    }

    return true;
  }

  /// Checks if the [widgetbook] directory is a valid widgetbook project.
  /// By checking for the presence of a pubspec.yaml file
  /// and widgetbook dependency in the pubspec.yaml file.
  /// If the [widgetbook] is different from the [package],
  /// it checks if the widgetbook project imports the flutter project in the
  /// [package] directory.
  bool _isValidWidgetbook() {
    final pubspecFile = File('$widgetbook/pubspec.yaml');

    // Check if pubspec.yaml exists
    if (!pubspecFile.existsSync()) {
      throw InvalidWidgetbookPackageException(
        message:
            'pubspec.yaml file is missing for --widgetbook option $widgetbook, please provide a valid Widgetbook project root directory.',
      );
    }

    // Read the contents of pubspec.yaml
    final pubspecContent = pubspecFile.readAsStringSync();

    // Check for the presence of 'widgetbook' in the pubspec.yaml file
    if (!pubspecContent.contains('widgetbook:')) {
      throw InvalidWidgetbookPackageException(
        message:
            'Widgetbook dependency is missing for --widgetbook option $widgetbook, please provide a valid Widgetbook project root directory.',
      );
    }

    // if widgetbook context is a different project, check if the widgetbook
    // project imports the flutter project
    if (widgetbook != package) {
      if (!pubspecContent.contains('$packageName:')) {
        throw InvalidWidgetbookPackageException(
        message:  'The widgetbook project for --widgetbook option $widgetbook does not depend on the Flutter project $packageName. Widgetbook project should depend on the Flutter project.',
        );
      }
    }

    if (!widgetbookUsecasesTarget.contains(widgetbook)) {
      throw InvalidWidgetbookPackageException(
        message:             'The widgetbook and widgetbook_usecases_target options should point to the same project. The widgetbook project is $widgetbook and the widgetbook_usecases_target project is $widgetbookUsecasesTarget.',

 
      );
    }

    return true;
  }

  bool _isValidDirectoryInputs() =>
      _isValidDirectory(
        package,
        option: 'package',
      ) &&
      _isValidDirectory(
        widgetbook,
        option: 'widgetbook',
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
      throw FolderNotFoundException(
        message: 'Empty path argument is invalid for option --$option.',
      );
    }

    if (directory.statSync().type != FileSystemEntityType.directory) {
      throw FolderNotFoundException(
        message:
            'Path $path is not a valid folder directory for option --$option.',
      );
    }

    if (!directory.existsSync()) {
      throw FolderNotFoundException(
        message: 'Folder directory path $path is not found for --$option.',
      );
    }

    if (directory.listSync().isEmpty) {
      throw FolderNotFoundException(
        message:
            'Empty folder directory path $path cannot be set as target for option --$option.',
      );
    }

    return true;
  }
}
