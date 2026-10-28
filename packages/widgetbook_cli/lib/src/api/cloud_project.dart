import 'package:mason_logger/mason_logger.dart';

import '../core/core.dart';
import 'widgetbook_http_client.dart';

/// A Widgetbook Cloud project, addressed by the ids of its workspace and
/// itself.
class CloudProject {
  const CloudProject({
    required this.workspaceId,
    required this.projectId,
    required this.name,
  });

  final String workspaceId;
  final String projectId;
  final String name;

  /// The API path that the routes acting on this project are nested under.
  String get path => 'v4/workspaces/$workspaceId/projects/$projectId';
}

extension CloudResolver on WidgetbookHttpClient {
  /// Returns the id of the one workspace the [apiKey] belongs to.
  Future<String> resolveWorkspaceId(String apiKey) async {
    final workspaces = await listWorkspaces(apiKey);

    if (workspaces.length != 1) {
      throw CliException(
        'Expected the API key to belong to exactly one workspace, '
        'but Widgetbook Cloud returned ${workspaces.length}.',
        ExitCode.data.code,
      );
    }

    return workspaces.single.id;
  }

  /// Returns the project called [name], or the only project the [apiKey]
  /// reaches if no [name] is given.
  Future<CloudProject> resolveProject(String apiKey, {String? name}) async {
    final workspaceId = await resolveWorkspaceId(apiKey);
    final projects = await listProjects(apiKey, workspaceId, name: name);

    if (name != null && projects.isEmpty) {
      throw CliException(
        "No project named '$name'. Create it with: "
        'widgetbook cloud project create --project ${_quote(name)}',
        ExitCode.data.code,
      );
    }

    if (projects.isEmpty) {
      throw CliException(
        'This API key reaches no project. Create one with: '
        'widgetbook cloud project create --project <name>',
        ExitCode.data.code,
      );
    }

    if (projects.length > 1) {
      throw CliException(
        'This API key reaches ${projects.length} projects. '
        'Pass --project <name> to choose one.',
        ExitCode.data.code,
      );
    }

    final project = projects.single;

    return CloudProject(
      workspaceId: workspaceId,
      projectId: project.id,
      name: project.name,
    );
  }
}

String _quote(String value) {
  return value.contains(RegExp(r'\s')) ? '"$value"' : value;
}
