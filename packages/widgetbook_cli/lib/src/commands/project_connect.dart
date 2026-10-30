import 'dart:async';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../core/core.dart';
import 'cloud_options.dart';
import 'project_connect_args.dart';

class ProjectConnectCommand extends CliCommand<ProjectConnectArgs> {
  ProjectConnectCommand({
    required super.context,
    super.logger,
    WidgetbookHttpClient? cloudClient,
  }) : cloudClient = cloudClient ?? WidgetbookHttpClient(),
       super(
         name: 'connect',
         description:
             'Connects a Widgetbook Cloud project to its Git repository.',
       ) {
    argParser
      ..addOption(
        'api-key',
        help: 'API key from your Widgetbook Cloud workspace settings',
        mandatory: true,
      )
      ..addProjectOption()
      ..addOption(
        'repository',
        help: 'Repository to connect (e.g. widgetbook/cool-app)',
        mandatory: true,
      )
      ..addOption(
        'provider',
        help: 'Git provider of the repository',
        allowed: ['github'],
        defaultsTo: 'github',
      )
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
  FutureOr<ProjectConnectArgs> parseResults(
    Context context,
    ArgResults results,
  ) {
    final repository = results['repository'] as String;

    if (!_isOwnerAndName(repository)) {
      throw CliException(
        'The option repository must have the form owner/name, '
        'got "$repository".',
        ExitCode.usage.code,
      );
    }

    return ProjectConnectArgs(
      apiKey: results['api-key'] as String,
      project: parseProjectOption(results),
      provider: results['provider'] as String,
      repository: repository,
    );
  }

  @override
  FutureOr<int> runWith(Context context, ProjectConnectArgs args) async {
    final progress = logger.progress(
      'Connecting the project to ${args.repository}',
    );

    try {
      final project = await cloudClient.resolveProject(
        args.apiKey,
        name: args.project,
      );

      final response = await cloudClient.connectRepository(
        args.apiKey,
        project,
        ConnectRepositoryRequest(
          provider: args.provider,
          repository: args.repository,
        ),
      );

      progress.complete(
        "Connected project '${project.name}' to ${response.repository}.",
      );

      return ExitCode.success.code;
    } catch (_) {
      progress.fail('Could not connect the project');
      rethrow;
    }
  }

  static bool _isOwnerAndName(String repository) {
    return RegExp(r'^[^/\s]+/[^/\s]+$').hasMatch(repository);
  }
}
