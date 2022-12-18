// The MIT License (MIT)
// Copyright (c) 2022 Widgetbook GmbH
// Copyright (c) 2022 Felix Angelov

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:

// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

import '../commands/commands.dart';
import '../helpers/helpers.dart';

/// The package name.
const packageName = 'widgetbook_cli';
const executableName = 'widgetbook';

class WidgetbookCommandRunner extends CommandRunner<int> {
  WidgetbookCommandRunner({
    Logger? logger,
    PubUpdater? pubUpdater,
  })  : _logger = logger ?? Logger(),
        _pubUpdater = pubUpdater ?? PubUpdater(),
        super(executableName, 'Widgetbook CLI') {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
    );
    addCommand(UpgradeCommand(logger: _logger, pubUpdater: _pubUpdater));

    addCommand(
      PublishCommand(
        logger: _logger,
      ),
    );
  }

  final Logger _logger;

  final PubUpdater _pubUpdater;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      return await runCommand(parse(args)) ?? ExitCode.success.code;
    } on FormatException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(e.usage);
      return ExitCode.usage.code;
    } on ProcessException catch (error) {
      _logger.err(error.message);
      return ExitCode.unavailable.code;
    } on GitDirectoryNotFound catch (error) {
      _logger.err(error.message);
      return ExitCode.data.code;
    } on DirectoryNotFoundException catch (error) {
      _logger.err(error.message);
      return ExitCode.usage.code;
    } on ExitedByUser catch (error) {
      _logger.info(error.message);
      return ExitCode.success.code;
    } on FileNotFoundException catch (error) {
      _logger.err(error.message);
      return ExitCode.usage.code;
    } on WidgetbookPublishReviewException catch (error) {
      _logger.err(error.message);
      return ExitCode.software.code;
    } on WidgetbookDeployException catch (error) {
      _logger.err(error.message);
      return ExitCode.software.code;
    } on ReviewNotFoundException catch (error) {
      _logger.warn(error.message);
      return ExitCode.success.code;
    } on WidgetbookApiException catch (error) {
      _logger.err(error.message);
      return ExitCode.software.code;
    } on UnableToCreateZipFileException catch (error) {
      _logger.err(error.message);
      return ExitCode.ioError.code;
    } catch (error) {
      _logger.err(error.toString());
      return ExitCode.software.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    int? exitCode = ExitCode.unavailable.code;
    if (topLevelResults['version'] == true) {
      _logger.info(packageVersion);
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }
    if (topLevelResults.command?.name != 'update') await _checkForUpdates();
    return exitCode;
  }

  Future<void> _checkForUpdates() async {
    try {
      final latestVersion = await _pubUpdater.getLatestVersion(packageName);
      final isUpToDate = packageVersion == latestVersion;
      if (!isUpToDate) {
        final changelogLink = lightCyan.wrap(
          styleUnderlined.wrap(
            link(
              uri: Uri.parse(
                'https://pub.dev/packages/widgetbook_cli/changelog',
              ),
            ),
          ),
        );
        _logger
          ..info('')
          ..info(
            '''
${lightYellow.wrap('Update available!')} ${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}
${lightYellow.wrap('Changelog:')} $changelogLink
Run ${cyan.wrap('$executableName update')} to update''',
          );
      }
    } catch (_) {}
  }
}
