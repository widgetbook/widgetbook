import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import '../../metadata.dart';
import '../analyzer/analyzer.dart';
import '../core/core.dart';
import '../templates/templates.dart';
import '../utils/executable_manager.dart';
import 'init_args.dart';

class InitCommand extends CliCommand<InitArgs> {
  InitCommand({
    required super.context,
    this.processManager = const LocalProcessManager(),
  }) : super(
         name: 'init',
         description: 'Initializes the widgetbook workspace.',
       ) {
    argParser
      ..addOption(
        'package',
        help: 'Directory of the app or the design system package',
        defaultsTo: './',
      )
      ..addOption(
        'output',
        help: 'Directory where the widgetbook workspace will be created',
        defaultsTo: './',
      );
  }

  final ProcessManager processManager;

  @override
  FutureOr<InitArgs> parseResults(Context context, ArgResults results) {
    final packageDir = results['package'] as String;
    final packagePubspec = File('${packageDir}/pubspec.yaml');
    if (!packagePubspec.existsSync()) {
      throw CliException(
        'No pubspec.yaml found in the package directory: $packageDir',
        ExitCode.data.code,
      );
    }

    final outputDir = results['output'] as String;

    return InitArgs(
      packageDir: packageDir,
      outputDir: outputDir,
    );
  }

  @override
  FutureOr<int> runWith(Context context, InitArgs args) async {
    logger.warn(
      'Experimental command 🧪\n'
      'Breaking changes are possible without prior notice.\n'
      'Please report any bugs or issues you encounter:\n'
      'https://github.com/widgetbook/widgetbook/issues\n',
    );

    final setupProgress = logger.progress('Setting up workspace');

    final packagePubspecFile = File('${args.packageDir}/pubspec.yaml');
    final packagePubspecContent = await packagePubspecFile.readAsString();
    final packageNameRegex = RegExp(r'name:\s+([a-zA-Z0-9_]+)');
    final match = packageNameRegex.firstMatch(packagePubspecContent);
    final packageName = match!.group(1)!;

    final widgetbookDir = p.join(args.outputDir, 'widgetbook');
    final relativePath = p.relative(args.packageDir, from: widgetbookDir);

    await processManager.runFlutter([
      'create',
      widgetbookDir,
      '--platforms=web,${Platform.operatingSystem}',
      '--project-name=widgetbook_workspace',
      '--description=Widgetbook workspace',
      '--empty',
    ]);

    final templates = [ConfigTemplate(), MainTemplate(), TestTemplate()];
    await Future.wait(
      templates.map(
        (template) => template.create(widgetbookDir),
      ),
    );

    await processManager.runFlutter(
      workingDirectory: widgetbookDir,
      [
        'pub',
        'add',
        'widgetbook:"^$widgetbookVersion"',
        'dev:build_runner',
        '$packageName:{path: $relativePath}',
      ],
    );

    setupProgress.complete('Workspace is set up at $widgetbookDir');

    final widgets = await _getWidgets(args.packageDir);
    // One source file can contain multiple widgets.
    // So we group them by their source file path, and add
    // an index to the stories filename in case of conflicts.
    final pathsMap = widgets.fold<Map<String, List<WidgetInfo>>>(
      {},
      (map, widget) {
        map[widget.filePath] = [...?map[widget.filePath], widget];
        return map;
      },
    );

    final componentTemplates = pathsMap.entries.expand<ComponentTemplate>(
      (entry) {
        final widgetsInPath = entry.value;

        if (widgetsInPath.length == 1) {
          final widgetInfo = widgetsInPath.first;
          return [
            ComponentTemplate(
              widgetInfo.storiesFilename,
              widgetInfo,
            ),
          ];
        }

        // When multiple entries share a source file (multiple widgets and/or
        // named constructors), use storiesFilename which already includes the
        // constructor name. Fall back to indexing only when names still collide.
        final filenames = widgetsInPath.map((w) => w.storiesFilename).toSet();
        if (filenames.length == widgetsInPath.length) {
          return widgetsInPath.map((widgetInfo) {
            return ComponentTemplate(
              widgetInfo.storiesFilename,
              widgetInfo,
            );
          }).toList();
        }

        return List.generate(
          widgetsInPath.length,
          (index) {
            final widgetInfo = widgetsInPath[index];
            return ComponentTemplate(
              '${widgetInfo.storiesFilename}_${index + 1}',
              widgetInfo,
            );
          },
        );
      },
    ).toList();

    await Future.wait(
      componentTemplates.map(
        (template) => template.create(widgetbookDir),
      ),
    );

    final buildProgress = logger.progress('Building stories');

    await processManager.runFlutter(
      workingDirectory: widgetbookDir,
      [
        'pub',
        'run',
        'build_runner',
        'build',
      ],
    );

    buildProgress.complete('Stories are built successfully');

    return ExitCode.success.code;
  }

  Future<Set<WidgetInfo>> _getWidgets(String packageDir) async {
    final progress = logger.progress('Resolving widgets');

    final widgets = await Isolate.run(() async {
      final analyzer = DeepAnalyzer(packageDir);
      return analyzer.collect(WidgetInfoCollector());
    });

    progress.complete('Found ${widgets.length} widgets');

    return widgets;
  }
}
