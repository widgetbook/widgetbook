import 'dart:async';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../api/cloud_exception.dart';
import '../core/core.dart';
import 'cloud_options.dart';
import 'project_create_args.dart';

class ProjectCreateCommand extends CliCommand<ProjectCreateArgs> {
  ProjectCreateCommand({
    required super.context,
    super.logger,
    WidgetbookHttpClient? cloudClient,
  }) : cloudClient = cloudClient ?? WidgetbookHttpClient(),
       super(
         name: 'create',
         description: 'Creates a project in your Widgetbook Cloud workspace.',
       ) {
    argParser
      ..addOption(
        'api-key',
        help: 'Workspace API key from Widgetbook Cloud',
        mandatory: true,
      )
      ..addOption(
        'project',
        help: 'Name of the project to create (e.g. my-app)',
        mandatory: true,
      )
      ..addFlag(
        'allow-existing',
        help:
            'Exit successfully instead of failing when a project with this '
            'name already exists in the workspace.',
        negatable: false,
      )
      ..addApiUrlOption(this.cloudClient);
  }

  final WidgetbookHttpClient cloudClient;

  @override
  FutureOr<ProjectCreateArgs> parseResults(
    Context context,
    ArgResults results,
  ) {
    final apiKey = ApiKey.parse(results['api-key'] as String);

    if (apiKey is! WorkspaceApiKey) {
      throw CliException(
        'Creating a project requires a workspace API key, which starts with '
        '${WorkspaceApiKey.prefix}. '
        'Create one in your Widgetbook Cloud workspace settings.',
        ExitCode.usage.code,
      );
    }

    final project = results['project'] as String;

    if (project.trim().isEmpty) {
      throw CliException(
        'The option project must not be empty.',
        ExitCode.usage.code,
      );
    }

    return ProjectCreateArgs(
      apiKey: apiKey,
      project: project,
      allowExisting: results['allow-existing'] as bool,
    );
  }

  @override
  FutureOr<int> runWith(Context context, ProjectCreateArgs args) async {
    final progress = logger.progress("Creating project '${args.project}'");

    try {
      final response = await cloudClient.createProject(
        CreateProjectRequest(
          apiKey: args.apiKey,
          name: args.project,
        ),
      );

      progress.complete("Project '${response.name}' created.");

      return ExitCode.success.code;
    } on CloudException catch (e) {
      if (args.allowExisting && e.statusCode == 409) {
        progress.complete("Project '${args.project}' already exists.");

        return ExitCode.success.code;
      }

      progress.fail('Could not create the project');

      if (e.statusCode == 409) {
        throw CliException(
          '${e.detail}\n'
          'Pass --allow-existing to exit successfully '
          'when the project already exists.',
          e.exitCode,
        );
      }

      rethrow;
    }
  }
}
