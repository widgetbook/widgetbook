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
import 'package:collection/collection.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import '../../core/core.dart';
import 'coverage_args.dart';

part 'get_components.dart';
part 'get_widgets.dart';
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
        'package-directory',
        defaultsTo: '.',
        help: 'Path for the app or the design system package.',
      )
      ..addOption(
        'widgetbook-directory',
        help: 'Path for the widgetbook app',
        defaultsTo: './widgetbook',
      )
      ..addOption(
        'min-coverage',
        help: 'Minimum coverage percentage required',
        defaultsTo: '90',
        valueHelp: '0-100',
      );
  }

  @override
  FutureOr<CoverageArgs> parseResults(Context context, ArgResults results) {
    final packageDir = results['package-directory'] as String;
    final packagePubspec = File('${packageDir}/pubspec.yaml');
    if (!packagePubspec.existsSync()) {
      throw CliException(
        'No pubspec.yaml found in the package directory: $packageDir',
        ExitCode.data.code,
      );
    }

    final widgetbookDir = results['widgetbook-directory'] as String;
    final widgetbookPubspec = File('${widgetbookDir}/pubspec.yaml');
    if (!widgetbookPubspec.existsSync()) {
      throw CliException(
        'No pubspec.yaml found in the widgetbook directory: $widgetbookDir',
        ExitCode.data.code,
      );
    }

    final minCoverage = int.tryParse(results['min-coverage'] as String);
    if (minCoverage == null || minCoverage < 0 || minCoverage > 100) {
      throw CliException(
        'Invalid min-coverage value. Must be between 0 and 100.',
        ExitCode.data.code,
      );
    }

    return CoverageArgs(
      // Use absolute paths as needed by the analysis context
      packageDir: p.canonicalize(packageDir),
      widgetbookDir: p.canonicalize(widgetbookDir),
      minCoverage: minCoverage,
    );
  }

  @override
  FutureOr<int> runWith(Context context, CoverageArgs args) async {
    final pathsProgress = logger.progress('Discovering paths');
    final widgetPaths = _getFilePaths(args.packageDir);
    final widgetbookPaths = _getFilePaths(args.widgetbookDir);
    pathsProgress.complete();

    final [widgets, components] = await Future.wait([
      _getWidgets(
        PathData(
          filePaths: widgetPaths,
          projectRootPath: args.packageDir,
        ),
        logger,
      ),
      _getComponents(
        PathData(
          filePaths: widgetbookPaths,
          projectRootPath: args.widgetbookDir,
        ),
        logger,
      ),
    ]);

    // We exclude private widgets (those starting with '_') from the coverage
    // calculation as they are not meant to be used outside their library.
    final privateWidgets = widgets.where((x) => x.startsWith('_')).toSet();
    final publicWidgets = widgets.difference(privateWidgets);
    final uncoveredWidgets = publicWidgets.difference(components);
    final coveredWidgets = publicWidgets.difference(uncoveredWidgets);

    final coverage = (coveredWidgets.length / (publicWidgets.length)) * 100;
    final isSatisfied = coverage >= args.minCoverage;

    logger.info('\n');
    coveredWidgets.forEach((widget) => logger.success('✅ $widget'));
    uncoveredWidgets.forEach((widget) => logger.err('❌ $widget'));
    privateWidgets.forEach((widget) => logger.info('🔒 $widget'));
    logger.info('\n');

    logger.info('Total     : ${widgets.length}');
    logger.info('Covered   : ${coveredWidgets.length}');
    logger.info('Uncovered : ${uncoveredWidgets.length}');
    logger.info('Private   : ${privateWidgets.length}');
    logger.info(
      'Coverage  : ${coverage.toStringAsFixed(2)}% ${isSatisfied ? '✅' : '❌'}',
    );

    return isSatisfied ? ExitCode.success.code : -8;
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
}
