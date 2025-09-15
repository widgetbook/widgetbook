import 'dart:async';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

import '../../metadata.dart';
import '../core/core.dart';

class UpgradeCommand extends CliVoidCommand {
  UpgradeCommand({
    required super.context,
    required this.pubUpdater,
    super.logger,
  }) : super(
         name: 'upgrade',
         description: 'Upgrade Widgetbook CLI',
       );

  final PubUpdater pubUpdater;

  @override
  FutureOr<int> runWith(Context context, ArgResults args) async {
    final updateCheckProgress = logger.progress('Checking for updates');

    try {
      final isUpToDate = await pubUpdater.isUpToDate(
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
      final latestVersion = await pubUpdater.getLatestVersion(
        packageName,
      );

      await pubUpdater.update(
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
