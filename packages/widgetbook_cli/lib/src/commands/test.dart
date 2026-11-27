import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:process/process.dart';

import '../core/core.dart';
import '../test/build_runner_lock.dart';
import '../test/selection.dart';
import '../test/stories_resolver.dart';
import '../test/test_exit_codes.dart';
import '../test/version_check.dart';
import '../utils/executable_manager.dart';
import 'test_args.dart';

class TestCommand extends CliCommand<TestArgs> {
  TestCommand({
    required super.context,
    super.logger,
    this.processManager = const LocalProcessManager(),
    this.buildRunnerRunning = isBuildRunnerRunning,
    String? workingDirectory,
  }) : workingDirectory = workingDirectory ?? Directory.current.path,
       super(
         name: 'test',
         description:
             'Runs the scenarios of the selected stories via flutter test.',
       ) {
    argParser
      ..addMultiOption(
        'path',
        help:
            'A .stories.dart file, a folder or a glob whose components '
            'are tested.',
        valueHelp: 'file|folder|glob',
        splitCommas: false,
      )
      ..addMultiOption(
        'filter',
        help:
            'A component, story or scenario to test, e.g. Counter/Default. '
            '"*" matches any name at a level.',
        valueHelp: 'Component[/Story[/Scenario]]',
        splitCommas: false,
      )
      ..addFlag(
        'snapshots',
        help: 'Write the snapshot (PNG and JSON) of each scenario.',
        defaultsTo: true,
      )
      ..addFlag(
        'build-runner',
        help:
            'Run "dart run build_runner build" first, so new stories '
            'are not skipped.',
        defaultsTo: true,
      )
      ..addOption(
        'target',
        help: 'The test file that calls testWidgetbook.',
        defaultsTo: 'test/widgetbook_test.dart',
      );
  }

  final ProcessManager processManager;

  /// Whether a `build_runner` process is running on the given package.
  final bool Function(String packageDir) buildRunnerRunning;

  /// The directory of the Widgetbook project.
  final String workingDirectory;

  @override
  String get invocation {
    return '${super.invocation} [-- <flutter test arguments>]';
  }

  @override
  FutureOr<TestArgs> parseResults(Context context, ArgResults results) {
    final target = results['target'] as String;
    if (!File(p.join(workingDirectory, target)).existsSync()) {
      throw CliException(
        '$target not found; pass the file that calls testWidgetbook '
        'via --target',
        TestExitCodes.pathNotFound,
      );
    }

    final filters = (results['filter'] as List<String>)
        .map(Selection.parse)
        .toList();

    final components = StoriesResolver(
      workingDirectory,
    ).resolve(results['path'] as List<String>);

    final snapshots = results['snapshots'] as bool;
    if (!snapshots) {
      checkWidgetbookVersion(
        projectDir: workingDirectory,
        flag: '--no-snapshots',
        minVersion: minSnapshotsDefineVersion,
      );
    }

    return TestArgs(
      components: components,
      filters: filters,
      snapshots: snapshots,
      buildRunner: results['build-runner'] as bool,
      target: target,
      flutterArgs: results.rest,
    );
  }

  @override
  FutureOr<int> runWith(Context context, TestArgs args) async {
    logger.warn(
      'Experimental command 🧪\n'
      'Breaking changes are possible without prior notice.\n'
      'Please report any bugs or issues you encounter:\n'
      'https://github.com/widgetbook/widgetbook/issues\n',
    );

    if (args.buildRunner && buildRunnerRunning(workingDirectory)) {
      logger.info(
        'build_runner is already running (e.g. build_runner watch), '
        'so the build step is skipped.',
      );
    } else if (args.buildRunner) {
      final exitCode = await processManager.stream(
        'dart',
        ['run', 'build_runner', 'build'],
        workingDirectory: workingDirectory,
      );

      if (exitCode != 0) {
        throw CliException(
          'build_runner failed with exit code $exitCode, '
          'so the scenarios were not run.',
          TestExitCodes.buildRunnerFailed,
        );
      }
    }

    final nameRegex = buildNameRegex(args.selections);
    var allSkipped = false;

    final exitCode = await processManager.stream(
      'flutter',
      [
        'test',
        args.target,
        if (nameRegex != null) ...['--name', nameRegex],
        if (!args.snapshots) '--dart-define=WIDGETBOOK_SNAPSHOTS=false',
        ...args.flutterArgs,
      ],
      workingDirectory: workingDirectory,
      onLine: (line) {
        if (_allSkippedPattern.hasMatch(line)) allSkipped = true;
      },
    );

    final selection = args.descriptions.isEmpty
        ? 'The catalog'
        : args.descriptions.join(', ');

    if (exitCode == TestExitCodes.noTestsRan) {
      throw CliException(
        args.buildRunner
            ? '$selection ran no scenarios; check that the names match '
                  'and that the component is in the Config components.'
            : '$selection ran no scenarios; its generated code may be stale. '
                  'Run without --no-build-runner.',
        TestExitCodes.noTestsRan,
      );
    }

    if (exitCode == 0 && allSkipped) {
      throw CliException(
        'All scenarios of $selection are excluded via excludeFromTests',
        TestExitCodes.allSkipped,
      );
    }

    return exitCode;
  }

  /// The summary line of `flutter test` when every test is skipped, for the
  /// default (compact and expanded) and the github reporters.
  static final _allSkippedPattern = RegExp(
    r'All tests skipped\.|\b0 tests passed, \d+ skipped\.',
  );
}
