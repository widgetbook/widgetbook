import 'dart:async';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../core/core.dart';
import 'cloud_options.dart';
import 'project_disconnect_args.dart';

class ProjectDisconnectCommand extends CliCommand<ProjectDisconnectArgs> {
  ProjectDisconnectCommand({
    required super.context,
    super.logger,
    WidgetbookHttpClient? cloudClient,
  }) : cloudClient = cloudClient ?? WidgetbookHttpClient(),
       super(
         name: 'disconnect',
         description:
             'Disconnects a Widgetbook Cloud project from its Git repository.',
       ) {
    argParser
      ..addOption(
        'api-key',
        help: 'API key from your Widgetbook Cloud workspace settings',
        mandatory: true,
      )
      ..addProjectOption()
      ..addApiUrlOption();
  }

  final WidgetbookHttpClient cloudClient;

  @override
  FutureOr<int>? run() {
    final apiUrl = parseApiUrlOption(argResults!);
    if (apiUrl != null) cloudClient.baseUrl = apiUrl;

    return super.run();
  }

  @override
  FutureOr<ProjectDisconnectArgs> parseResults(
    Context context,
    ArgResults results,
  ) {
    return ProjectDisconnectArgs(
      apiKey: results['api-key'] as String,
      project: parseProjectOption(results),
    );
  }

  @override
  FutureOr<int> runWith(Context context, ProjectDisconnectArgs args) async {
    final progress = logger.progress('Disconnecting the project');

    try {
      await cloudClient.disconnectRepository(
        args.apiKey,
        projectName: args.project,
      );

      progress.complete(
        args.project != null
            ? "Disconnected project '${args.project}' from its repository."
            : "Disconnected the project's repository.",
      );

      return ExitCode.success.code;
    } catch (_) {
      progress.fail('Could not disconnect the project');
      rethrow;
    }
  }
}
