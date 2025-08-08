import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

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
        'package',
        help: 'Directory of the app or the design system package',
        defaultsTo: './',
      )
      ..addOption(
        'widgetbook',
        help: 'Directory of the widgetbook app',
        defaultsTo: './widgetbook',
      )
      ..addOption(
        'min-coverage',
        help: 'Minimum coverage percentage required',
        defaultsTo: '100',
        valueHelp: '0-100',
      );
  }

  @override
  FutureOr<CoverageArgs> parseResults(Context context, ArgResults results) {
    final packageDir = results['package'] as String;
    final packagePubspec = File('${packageDir}/pubspec.yaml');
    if (!packagePubspec.existsSync()) {
      throw CliException(
        'No pubspec.yaml found in the package directory: $packageDir',
        ExitCode.data.code,
      );
    }

    final widgetbookDir = results['widgetbook'] as String;
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
      packageDir: packageDir,
      widgetbookDir: widgetbookDir,
      minCoverage: minCoverage,
    );
  }

  @override
  FutureOr<int> runWith(Context context, CoverageArgs args) async {
    logger.warn(
      'Experimental command 🧪\n'
      'Breaking changes are possible without prior notice.\n'
      'Please report any bugs or issues you encounter:\n'
      'https://github.com/widgetbook/widgetbook/issues\n',
    );

    // We run both these functions in parallel and in isolates because they
    // are both heavy and blocking operations that can block the loader from
    // the [logger.progress]
    final [widgets, components] = await Future.wait([
      _getWidgets(args.packageDir),
      _getComponents(args.widgetbookDir),
    ]);

    final uncoveredWidgets = widgets.difference(components);
    final coveredWidgets = widgets.difference(uncoveredWidgets);

    final coverage = (coveredWidgets.length / (widgets.length)) * 100;
    final isSatisfied = coverage >= args.minCoverage;

    logger.info('\nCovered Widgets (${coveredWidgets.length})');
    coveredWidgets.forEach((widget) => logger.success('✅ $widget'));

    logger.info('\nUncovered Widgets (${uncoveredWidgets.length})');
    uncoveredWidgets.forEach((widget) => logger.err('❌ $widget'));

    logger.info(
      '\n${isSatisfied ? '✅' : '❌'} '
      'Coverage (${coverage.toStringAsFixed(2)}%)',
    );

    return isSatisfied ? ExitCode.success.code : -8;
  }

  Future<Set<String>> _getComponents(String widgetbookDir) async {
    final progress = logger.progress('Resolving components');

    final components = await Isolate.run(() {
      final analyzer = ShallowAnalyzer(widgetbookDir);
      return analyzer.collect(ComponentCollector());
    });

    progress.complete(
      'Found ${components.length} components',
    );

    return components;
  }

  Future<Set<String>> _getWidgets(String packageDir) async {
    final progress = logger.progress('Resolving widgets');

    final widgets = await Isolate.run(() async {
      final analyzer = DeepAnalyzer(packageDir);
      return analyzer.collect(WidgetCollector());
    });

    progress.complete('Found ${widgets.length} widgets');

    return widgets;
  }
}
