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

import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

import '../helpers/metadata.dart';
import 'command.dart';

class UpgradeCommand extends WidgetbookCommand {
  UpgradeCommand({
    required PubUpdater pubUpdater,
    super.logger,
  }) : _pubUpdater = pubUpdater;

  final PubUpdater _pubUpdater;

  @override
  final String description = 'Upgrade Widgetbook CLI';

  @override
  final String name = 'upgrade';

  @override
  Future<int> run() async {
    final updateCheckProgress = logger.progress('Checking for updates');

    try {
      final isUpToDate = await _pubUpdater.isUpToDate(
        packageName: packageName,
        currentVersion: packageVersion,
      );

      if (isUpToDate) {
        logger.info('Widgetbook CLI is already at the latest version.');
        return ExitCode.success.code;
      }

      updateCheckProgress.complete('Checked for updates');
    } catch (error) {
      updateCheckProgress.fail();
      logger.err('$error');
      return ExitCode.software.code;
    }

    final updateProgress = logger.progress('Upgrading to latest version');

    try {
      final latestVersion = await _pubUpdater.getLatestVersion(packageName);
      await _pubUpdater.update(
        packageName: packageName,
      );

      updateProgress.complete('Upgraded to $latestVersion');
      return ExitCode.success.code;
    } catch (err) {
      updateProgress.fail();
      logger.err(err.toString());
      return ExitCode.software.code;
    }
  }
}
