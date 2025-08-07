import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import '../analyzer/analyzer.dart';
import '../core/core.dart';
import 'coverage_args.dart';

class CoverageCommand extends CliCommand<CoverageArgs> {
  CoverageCommand({
    required super.context,
  }) : super(
         name: 'coverage',
         description:
             'Checks the percentage of package widgets that are covered '
             'by at least one use-case in Widgetbook.',
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
    logger.warn(
      'Experimental command 🧪 \n'
      'Breaking changes are possible without prior notice.\n'
      'Please report any bugs or issues you encounter:\n'
      'https://github.com/widgetbook/widgetbook/issues\n',
    );

    // We run both these functions in parallel and in isolates because they
    // are both heavy and blocking operations that can block the loader from
    // the [logger.progress]
    final [widgets, components] = await Future.wait([
      _getWidgets(p.join(args.packageDir, 'lib'), logger),
      _getComponents(p.join(args.widgetbookDir, 'lib'), logger),
    ]);

    final uncoveredWidgets = widgets.difference(components);
    final coveredWidgets = widgets.difference(uncoveredWidgets);

    final coverage = (coveredWidgets.length / (widgets.length)) * 100;
    final isSatisfied = coverage >= args.minCoverage;

    logger.info('\n');
    coveredWidgets.forEach((widget) => logger.success('✅ $widget'));
    uncoveredWidgets.forEach((widget) => logger.err('❌ $widget'));
    logger.info('\n');

    logger.info('Total     : ${widgets.length}');
    logger.info('Covered   : ${coveredWidgets.length}');
    logger.info('Uncovered : ${uncoveredWidgets.length}');
    logger.info(
      'Coverage  : ${coverage.toStringAsFixed(2)}% ${isSatisfied ? '✅' : '❌'}',
    );

    return isSatisfied ? ExitCode.success.code : -8;
  }

  Future<Set<String>> _getComponents(
    String widgetbookDir,
    Logger logger,
  ) async {
    final progress = logger.progress('Resolving components in $widgetbookDir');

    final components = await Isolate.run(() {
      final analyzer = ShallowAnalyzer(widgetbookDir);
      return analyzer.collect(ComponentCollector());
    });

    progress.complete(
      'Found ${components.length} components in $widgetbookDir',
    );

    return components;
  }

  Future<Set<String>> _getWidgets(
    String packageDir,
    Logger logger,
  ) async {
    final progress = logger.progress('Resolving widgets in $packageDir');

    final widgets = await Isolate.run(() async {
      final analyzer = DeepAnalyzer(packageDir);
      return analyzer.collect(WidgetCollector());
    });

    progress.complete('Found ${widgets.length} widgets in $packageDir');

    return widgets;
  }
}
