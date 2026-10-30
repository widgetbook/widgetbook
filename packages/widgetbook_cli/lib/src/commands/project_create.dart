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
        help: 'API key from your Widgetbook Cloud workspace settings',
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
  FutureOr<ProjectCreateArgs> parseResults(
    Context context,
    ArgResults results,
  ) {
    return ProjectCreateArgs(
      apiKey: results['api-key'] as String,
      project: parseProjectOption(results)!,
      allowExisting: results['allow-existing'] as bool,
    );
  }

  @override
  FutureOr<int> runWith(Context context, ProjectCreateArgs args) async {
    final progress = logger.progress("Creating project '${args.project}'");

    try {
      final response = await cloudClient.createProject(
        args.apiKey,
        CreateProjectRequest(name: args.project),
      );

      progress.complete("Project '${response.name}' created.");

      return ExitCode.success.code;
    } on CloudException catch (e) {
      if (e.statusCode == 409 && args.allowExisting) {
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
    } catch (_) {
      progress.fail('Could not create the project');
      rethrow;
    }
  }
}
