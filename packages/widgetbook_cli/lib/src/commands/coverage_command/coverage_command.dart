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
part 'widget_visitor.dart';
part 'widgetbook_use_case_visitor.dart';

class CoverageCommand extends CliCommand<CoverageArgs> {
  CoverageCommand({
    required super.context,
  }) : super(
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
        'min-coverage',
        help:
            'Minimum coverage percentage required, integer value from (0-100).',
        defaultsTo: '50',
      );
  }

  final UserInputValidityChecker _userInputValidityChecker =
      UserInputValidityChecker();

  @override
  FutureOr<CoverageArgs> parseResults(Context context, ArgResults results) {
    final package = _getOptionPath('package', results);
    final widgetbook = _getOptionPath('widgetbook', results);
    final minCoverage = _getMinCoverageInput(results);

    if (!_isValidDirectoryInputs(package, widgetbook)) {
      throw FolderNotFoundException();
    }

    if (!_userInputValidityChecker.isPackage(
          package,
        ) ||
        !_userInputValidityChecker.isValidWidgetbook(
          widgetbook,
          package,
        )) {
      throw FolderNotFoundException();
    }

    return CoverageArgs(
      package: package,
      widgetbook: widgetbook,
      minCoverage: minCoverage,
    );
  }

  @override
  FutureOr<int> runWith(Context context, CoverageArgs args) async {
    final package = args.package;
    final widgetbook = args.widgetbook;

    final pathsProgress = logger.progress('Discovering paths');
    final widgetPaths = _getFilePaths(package);
    final widgetbookPaths = _getFilePaths(widgetbook);
    pathsProgress.complete();

    /* ------------------------ get widgets and usecases ------------------------ */
    final futures = await Future.wait([
      _getProjectWidgets(
        PathData(
          filePaths: widgetPaths,
          projectRootPath: package,
        ),
        logger,
      ),
      _getProjectWidgetbookUseCases(
        PathData(
          filePaths: widgetbookPaths,
          projectRootPath: widgetbook,
        ),
        logger,
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

    logger.info('\n');
    coveredWidgets.forEach((widget) => logger.success('✅ ${widget}'));
    uncoveredWidgets.forEach((widget) => logger.err('❌ ${widget}'));
    logger.info('\n');

    final coverage =
        (coveredWidgets.length /
            (coveredWidgets.length + uncoveredWidgets.length)) *
        100;

    final isSatisfied = coverage >= args.minCoverage;

    logger.info('Total     : ${widgets.length}');
    logger.info('Covered   : ${coveredWidgets.length}');
    logger.info('Uncovered : ${uncoveredWidgets.length}');
    logger.info('Private   : ${privateWidgets.length}');
    logger.info(
      'Coverage  : ${coverage.toStringAsFixed(2)}% ${isSatisfied ? '✅' : '❌'}',
    );

    return isSatisfied ? ExitCode.success.code : -8;
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
    final dartFiles =
        Directory(directoryPath)
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
  ) =>
      _userInputValidityChecker.isValidDirectory(
        package,
        option: 'package',
      ) &&
      _userInputValidityChecker.isValidDirectory(
        widgetbook,
        option: 'widgetbook',
      );
}
