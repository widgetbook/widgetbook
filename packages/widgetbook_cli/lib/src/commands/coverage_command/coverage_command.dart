// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import '../../../widgetbook_cli.dart';
import 'coverage_args.dart';
import 'user_input_validity_checker.dart';

part 'get_project_widgetbook_usecases.dart';
part 'get_project_widgets.dart';
part 'models.dart';
part 'time_logger.dart';
part 'widget_visitor.dart';
part 'widgetbook_use_case_visitor.dart';

class CoverageCommand extends CliCommand<CoverageArgs> {
  CoverageCommand({
    required Logger logger,
    required super.context,
  })  : _logger = logger,
        super(
          name: 'coverage',
          description:
              'A command that checks for widgetbook coverage in a package.',
        ) {
    argParser
      ..addOption(
        'package',
        help: 'Target path of the Flutter package.',
        mandatory: true,
      )
      ..addOption(
        'widgetbook',
        help: 'Target path of the widgetbook package.',
        mandatory: true,
      )
      ..addOption(
        'widgets-target',
        help:
            'Target path for the root widgets folder.\n(defaults to <package>/lib)',
      )
      ..addOption(
        'widgetbook-usecases-target',
        help:
            'Target path for the root usecases folder.\n(defaults to <widgetbook>/lib)',
      )
      ..addOption(
        'min-coverage',
        help:
            'Minimum coverage percentage required, integer value from (0-100).',
        defaultsTo: '50',
      );
  }

  final Logger _logger;
  late final TimeLogger _timeLogger = TimeLogger(_logger);
  final UserInputValidityChecker _userInputValidityChecker =
      UserInputValidityChecker();

  @override
  FutureOr<CoverageArgs> parseResults(Context context, ArgResults results) {
    final package = _getOptionPath('package', results);
    final widgetbook = _getOptionPath('widgetbook', results);
    final widgetsTarget =
        results['widgets-target'] as String? ?? '$package/lib';
    final widgetbookUsecasesTarget =
        results['widgetbook-usecases-target'] as String? ?? '$widgetbook/lib';
    final minCoverage = _getMinCoverageInput(results);

    /* ---------------------- validity checks of the input ---------------------- */
    _timeLogger.start('Validating input directories...');
    if (!_isValidDirectoryInputs(
      package,
      widgetbook,
      widgetsTarget,
      widgetbookUsecasesTarget,
    )) {
      throw FolderNotFoundException();
    }

    if (!_userInputValidityChecker.isPackage(
          package,
          widgetsTarget: widgetsTarget,
        ) ||
        !_userInputValidityChecker.isValidWidgetbook(
          widgetbook,
          package,
          widgetbookUsecasesTarget: widgetbookUsecasesTarget,
        )) {
      throw FolderNotFoundException();
    }
    _timeLogger.stop('Finished validating input directories.');
    /* ---------------------- validity checks of the input ---------------------- */

    return CoverageArgs(
      package: package,
      widgetbook: widgetbook,
      widgetsTarget: widgetsTarget,
      widgetbookUsecasesTarget: widgetbookUsecasesTarget,
      minCoverage: minCoverage,
    );
  }

  @override
  FutureOr<int> runWith(Context context, CoverageArgs args) async {
    final package = args.package;
    final widgetbook = args.widgetbook;
    final widgetsTarget = args.widgetsTarget;
    final widgetbookUsecasesTarget = args.widgetbookUsecasesTarget;

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
    /* ------------------------ get widgets and usecases ------------------------ */

    /* ---------------------- compare widgets and usecases ---------------------- */
    final coveredWidgets = <String>[];
    final uncoveredWidgets = <String>[];
    final privateWidgets = <String>[];

    // get covered widgets
    for (var usecase in usecases) {
      if (widgets.contains(usecase)) {
        coveredWidgets.add(usecase);
      }
    }

    //get uncovered widgets
    for (var widget in widgets) {
      if (!usecases.contains(widget) && !widget.startsWith('_')) {
        uncoveredWidgets.add(widget);
      }
    }

    // get private widgets
    privateWidgets.addAll(
      widgets.where(
        (widget) => widget.startsWith('_'),
      ),
    );

    /* ---------------------- compare widgets and usecases ---------------------- */

    /* ------------------------------ print results ----------------------------- */
    _logger.info('Covered widgets: ${coveredWidgets.length}');
    _logger.info('Uncovered widgets: ${uncoveredWidgets.length}');
    _logger.info('Private widgets: ${privateWidgets.length}');
    _logger.info('Widget Name'.padRight(50) + ' | Coverage Status');
    coveredWidgets.forEach((widget) {
      _logger.info('${widget.padRight(50)} | ✅ Covered');
    });
    uncoveredWidgets.forEach((widget) {
      _logger.info('${widget.padRight(50)} | ❌ Uncovered');
    });
    /* ------------------------------ print results ----------------------------- */

    /* ---------------------- calculate coverage percentage --------------------- */
    final coveredWidgetsPercentage = (coveredWidgets.length /
            (coveredWidgets.length + uncoveredWidgets.length)) *
        100;

    if (coveredWidgetsPercentage < args.minCoverage) {
      throw '❌ Insufficient coverage of $coveredWidgetsPercentage% found, '
          'minimum coverage of ${args.minCoverage}% required!';
    } else {
      _logger.info(
        '✅ Minimum coverage of ${args.minCoverage}% is satisfied with $coveredWidgetsPercentage% coverage!',
      );
    }
    /* ---------------------- calculate coverage percentage --------------------- */

    return ExitCode.success.code;
  }

  String _getOptionPath(String option, ArgResults results) {
    final path = results[option] as String?;

    if (path == null) {
      throw FolderNotFoundException(
        message:
            '$option path not found, please provide a valid $option path using the "--$option" option.',
      );
    }

    if (path == '.') return Directory.current.path;
    if (path == '..') return Directory.current.parent.path;
    return Directory(path).absolute.path;
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

  /// if not an integer it will throw and if not between 0 and 100 it will throw.
  /// Else it will return the integer value.
  int _getMinCoverageInput(ArgResults results) {
    try {
      final minCoverage = int.parse(results['min-coverage'] as String);
      if (minCoverage < 0 || minCoverage > 100) {
        throw Exception();
      }

      return minCoverage;
    } catch (e) {
      throw InvalidInputException(
        message:
            'Invalid min-coverage value, please provide a valid integer value between 0 and 100.',
      );
    }
  }

  bool _isValidDirectoryInputs(
    String package,
    String widgetbook,
    String widgetsTarget,
    String widgetbookUsecasesTarget,
  ) =>
      _userInputValidityChecker.isValidDirectory(
        package,
        option: 'package',
      ) &&
      _userInputValidityChecker.isValidDirectory(
        widgetbook,
        option: 'widgetbook',
      ) &&
      _userInputValidityChecker.isValidDirectory(
        widgetsTarget,
        option: 'widgets_target',
      ) &&
      _userInputValidityChecker.isValidDirectory(
        widgetbookUsecasesTarget,
        option: 'widgetbook_usecases_target',
      );
}
