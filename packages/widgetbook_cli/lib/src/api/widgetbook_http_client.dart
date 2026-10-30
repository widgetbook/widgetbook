import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';

import '../core/core.dart';

import 'cloud_exception.dart';
import 'cloud_project.dart';
import 'models/append_snapshots_request.dart';
import 'models/append_snapshots_response.dart';
import 'models/connect_repository_request.dart';
import 'models/connect_repository_response.dart';
import 'models/create_build_request.dart';
import 'models/create_build_response.dart';
import 'models/create_project_request.dart';
import 'models/list_projects_response.dart';
import 'models/list_workspaces_response.dart';
import 'models/project_response.dart';
import 'models/skip_review_request.dart';
import 'models/skip_review_response.dart';
import 'models/submit_build_response.dart';
import 'models/versions_metadata.dart';
import 'models/workspace_response.dart';

const BASE_API_URL = 'https://api.widgetbook.io/';

/// Widgetbook learns about pull requests from git-provider webhooks, which can
/// land after a fast CI job starts. A 404 for an unknown pull request is
/// therefore often a race rather than a real error, so the first few are
/// retried before giving up.
const _skipReviewRetryDelays = [
  Duration(seconds: 3),
  Duration(seconds: 5),
  Duration(seconds: 8),
];

/// HTTP client to connect to the Widgetbook Cloud backend.
/// Every request sends the API key as a bearer token.
class WidgetbookHttpClient {
  WidgetbookHttpClient({
    Dio? client,
    Uri? baseUrl,
  }) : client =
           client ??
           Dio(
             BaseOptions(
               baseUrl: BASE_API_URL,
               contentType: Headers.jsonContentType,
             ),
           ) {
    if (baseUrl != null) this.baseUrl = baseUrl;
  }

  final Dio client;

  Uri get baseUrl => Uri.parse(client.options.baseUrl);

  /// Dio appends the relative request paths to the base URL as strings, so
  /// the base URL is stored with exactly one trailing slash.
  set baseUrl(Uri url) {
    final normalized = url.path.endsWith('/')
        ? url
        : url.replace(path: '${url.path}/');

    client.options.baseUrl = normalized.toString();
  }

  /// Lists the workspaces the [apiKey] belongs to.
  Future<List<WorkspaceResponse>> listWorkspaces(String apiKey) async {
    try {
      final response = await client.get<Map<String, dynamic>>(
        'v4/workspaces',
        options: _options(apiKey),
      );

      return ListWorkspacesResponse.fromJson(response.data!).workspaces;
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// Lists the projects of [workspaceId] that the [apiKey] reaches, only the
  /// one called [name] if given.
  Future<List<ProjectResponse>> listProjects(
    String apiKey,
    String workspaceId, {
    String? name,
  }) async {
    try {
      final response = await client.get<Map<String, dynamic>>(
        'v4/workspaces/$workspaceId/projects',
        queryParameters: {if (name != null) 'name': name},
        options: _options(apiKey),
      );

      return ListProjectsResponse.fromJson(response.data!).projects;
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// Creates a project in the workspace of the [apiKey].
  Future<ProjectResponse> createProject(
    String apiKey,
    CreateProjectRequest request,
  ) async {
    final workspaceId = await _resolveWorkspaceId(apiKey);

    try {
      final response = await client.post<Map<String, dynamic>>(
        'v4/workspaces/$workspaceId/projects',
        data: request.toJson(),
        options: _options(apiKey),
      );

      return ProjectResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// Returns the project called [name], or the only project the [apiKey]
  /// reaches if no [name] is given.
  Future<CloudProject> resolveProject(String apiKey, {String? name}) async {
    final workspaceId = await _resolveWorkspaceId(apiKey);
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

  /// Connects the project called [projectName], or the only project the
  /// [apiKey] reaches, to the repository of the [request].
  Future<ConnectRepositoryResponse> connectRepository(
    String apiKey,
    ConnectRepositoryRequest request, {
    String? projectName,
  }) async {
    final project = await resolveProject(apiKey, name: projectName);

    try {
      final response = await client.put<Map<String, dynamic>>(
        '${project.path}/repository',
        data: request.toJson(),
        options: _options(apiKey),
      );

      return ConnectRepositoryResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// Disconnects the project called [projectName], or the only project the
  /// [apiKey] reaches, from its repository.
  Future<void> disconnectRepository(
    String apiKey, {
    String? projectName,
  }) async {
    final project = await resolveProject(apiKey, name: projectName);

    try {
      await client.delete<void>(
        '${project.path}/repository',
        options: _options(apiKey),
      );
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// Creates a new build that can be either a draft or a turbo build.
  Future<CreateBuildResponse> createBuild(
    String apiKey,
    CloudProject project,
    VersionsMetadata? versions,
    CreateBuildRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        '${project.path}/builds',
        data: request.toJson(),
        options: _options(apiKey, versions),
      );

      return CreateBuildResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// Appends a batch of snapshot metadata to an in-progress (draft) batched
  /// build created by [createBuild]. The [buildId] is a path param.
  Future<AppendSnapshotsResponse> appendSnapshots(
    String apiKey,
    CloudProject project,
    VersionsMetadata? versions,
    String buildId,
    AppendSnapshotsRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        '${project.path}/builds/$buildId/snapshots',
        data: request.toJson(),
        options: _options(apiKey, versions),
      );

      return AppendSnapshotsResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// If [createBuild] return s a [CreateDraftBuildResponse],
  /// this method can be used to submit the build draft.
  Future<SubmitBuildResponse> submitBuild(
    String apiKey,
    CloudProject project,
    String buildId,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        '${project.path}/builds/$buildId/submit',
        options: _options(apiKey),
      );

      return SubmitBuildResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// Marks the Widgetbook Review check of [prNumber] as passing, for a commit
  /// that will never get a build.
  Future<SkipReviewResponse> skipReview(
    String apiKey,
    CloudProject project,
    int prNumber,
    SkipReviewRequest request, {
    List<Duration> retryDelays = _skipReviewRetryDelays,
  }) async {
    for (var attempt = 0; ; attempt++) {
      try {
        final response = await client.post<Map<String, dynamic>>(
          '${project.path}/pull-requests/$prNumber/review-skip',
          data: request.toJson(),
          options: _options(apiKey),
        );

        return SkipReviewResponse.fromJson(response.data!);
      } catch (e, stackTrace) {
        final exception = CloudException.parse(e, stackTrace);

        final pullRequestNotSynced =
            exception.statusCode == 404 &&
            exception.detail.startsWith('No pull request #');

        if (!pullRequestNotSynced || attempt >= retryDelays.length) {
          throw exception;
        }

        await Future<void>.delayed(retryDelays[attempt]);
      }
    }
  }

  /// Returns the id of the one workspace the [apiKey] belongs to.
  Future<String> _resolveWorkspaceId(String apiKey) async {
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

  Options _options(String apiKey, [VersionsMetadata? versions]) {
    return Options(
      headers: {
        ...?versions?.toHeaders(),
        'Authorization': 'Bearer $apiKey',
      },
    );
  }

  static String _quote(String value) {
    return value.contains(RegExp(r'\s')) ? '"$value"' : value;
  }
}
