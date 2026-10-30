import 'package:test/test.dart';
import 'package:widgetbook_cli/src/api/cloud_exception.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';

const apiKey = 'widgetbook_secret';
const headSha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
const project = CloudProject(
  workspaceId: 'workspace-1',
  projectId: 'project-1',
  name: 'my-app',
);
const projectPath = '/v4/workspaces/workspace-1/projects/project-1';

const workspacesResponse = FakeResponse(200, {
  'workspaces': [
    {'id': 'workspace-1', 'name': 'My Workspace'},
  ],
});

FakeResponse projectsResponse(List<String> names) {
  return FakeResponse(200, {
    'projects': [
      for (final (i, name) in names.indexed)
        {
          'id': 'project-${i + 1}',
          'name': name,
          'createdAt': '2026-01-02T03:04:05.000Z',
        },
    ],
  });
}

WidgetbookHttpClient clientFor(FakeHttpAdapter adapter) {
  return WidgetbookHttpClient()..client.httpClientAdapter = adapter;
}

Future<CloudProject> resolve(FakeHttpAdapter adapter, {String? name}) {
  return clientFor(adapter).resolveProject(apiKey, name: name);
}

const createBuildRequest = CreateBuildRequest(
  versionControlProvider: 'GitHub',
  repository: 'widgetbook/app',
  actor: 'octocat',
  branch: 'main',
  sha: headSha,
  mergedResultSha: null,
  stories: [],
  expectedSnapshotCount: 3,
  size: 1024,
  hash: null,
);

Matcher throwsCloudException(int statusCode, String detail) {
  return throwsA(
    isA<CloudException>()
        .having((e) => e.statusCode, 'statusCode', statusCode)
        .having((e) => e.detail, 'detail', detail)
        .having((e) => e.message, 'message', contains(detail)),
  );
}

Matcher throwsCliException(String message) {
  return throwsA(
    isA<CliException>()
        .having((e) => e, 'type', isNot(isA<CloudException>()))
        .having((e) => e.message, 'message', message),
  );
}

void expectAuthorized(RecordedRequest request) {
  expect(request.header('Authorization'), equals('Bearer $apiKey'));
}

void expectNoCredentialInBody(RecordedRequest request) {
  expect(request.body ?? {}, isNot(contains('apiKey')));
  expect(request.body ?? {}, isNot(contains('projectName')));
}

void main() {
  group('$WidgetbookHttpClient', () {
    group('listWorkspaces', () {
      test('gets the workspaces of the key', () async {
        final adapter = FakeHttpAdapter([workspacesResponse]);

        final workspaces = await clientFor(adapter).listWorkspaces(apiKey);

        final request = adapter.requests.single;
        expect(request.method, equals('GET'));
        expect(request.uri.path, equals('/v4/workspaces'));
        expectAuthorized(request);
        expect(workspaces.single.id, equals('workspace-1'));
      });

      for (final detail in ['Missing API key.', 'Invalid API key.']) {
        test('shows the server message of a 401: $detail', () {
          final adapter = FakeHttpAdapter([
            FakeResponse(401, {'message': detail, 'statusCode': 401}),
          ]);

          expect(
            clientFor(adapter).listWorkspaces(apiKey),
            throwsCloudException(401, detail),
          );
        });
      }
    });

    group('listProjects', () {
      test('gets the projects of the workspace', () async {
        final adapter = FakeHttpAdapter([
          projectsResponse(['a', 'b']),
        ]);

        final projects = await clientFor(
          adapter,
        ).listProjects(apiKey, 'workspace-1');

        final request = adapter.requests.single;
        expect(request.method, equals('GET'));
        expect(request.uri.path, equals('/v4/workspaces/workspace-1/projects'));
        expect(request.uri.queryParameters, isEmpty);
        expectAuthorized(request);
        expect(projects.map((p) => p.name), equals(['a', 'b']));
      });

      test('filters by name', () async {
        final adapter = FakeHttpAdapter([
          projectsResponse(['my app']),
        ]);

        await clientFor(
          adapter,
        ).listProjects(apiKey, 'workspace-1', name: 'my app');

        final request = adapter.requests.single;
        expect(request.uri.path, equals('/v4/workspaces/workspace-1/projects'));
        expect(request.uri.queryParameters, equals({'name': 'my app'}));
      });
    });

    group('createProject', () {
      const request = CreateProjectRequest(name: 'my-app');

      test('posts the name to the workspace', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          const FakeResponse(201, {
            'id': 'project-1',
            'name': 'my-app',
            'createdAt': '2026-01-02T03:04:05.000Z',
          }),
        ]);

        final project = await clientFor(
          adapter,
        ).createProject(apiKey, request);

        final sent = adapter.requests.last;
        expect(sent.method, equals('POST'));
        expect(
          sent.uri.path,
          equals('/v4/workspaces/workspace-1/projects'),
        );
        expectAuthorized(sent);
        expect(sent.body, equals({'name': 'my-app'}));
        expect(project.id, equals('project-1'));
        expect(project.name, equals('my-app'));
      });

      test('shows the server message of a 409', () {
        const detail =
            'A project with this name already exists in this workspace.';
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          const FakeResponse(409, {'message': detail}),
        ]);

        expect(
          clientFor(adapter).createProject(apiKey, request),
          throwsCloudException(409, detail),
        );
      });
    });

    group('connectRepository', () {
      const request = ConnectRepositoryRequest(
        provider: 'github',
        repository: 'widgetbook/app',
      );

      test('puts the repository of the project', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse(['my-app']),
          const FakeResponse(200, {
            'provider': 'github',
            'repository': 'widgetbook/app',
            'project': {'id': 'project-1', 'name': 'my-app'},
          }),
        ]);

        final response = await clientFor(
          adapter,
        ).connectRepository(apiKey, request, projectName: 'my-app');

        final sent = adapter.requests.last;
        expect(sent.method, equals('PUT'));
        expect(sent.uri.path, equals('$projectPath/repository'));
        expectAuthorized(sent);
        expect(
          sent.body,
          equals({'provider': 'github', 'repository': 'widgetbook/app'}),
        );
        expect(response.repository, equals('widgetbook/app'));
        expect(response.projectName, equals('my-app'));
        expect(
          adapter.requests[1].uri.queryParameters,
          equals({'name': 'my-app'}),
        );
      });

      test('shows the server message of a 409', () {
        const detail = 'The project is connected to another repository.';
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse(['my-app']),
          const FakeResponse(409, {'message': detail}),
        ]);

        expect(
          clientFor(adapter).connectRepository(apiKey, request),
          throwsCloudException(409, detail),
        );
      });
    });

    group('disconnectRepository', () {
      test('deletes the repository of the project', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse(['my-app']),
          const FakeResponse(204, {}),
        ]);

        await clientFor(
          adapter,
        ).disconnectRepository(apiKey, projectName: 'my-app');

        final sent = adapter.requests.last;
        expect(sent.method, equals('DELETE'));
        expect(sent.uri.path, equals('$projectPath/repository'));
        expectAuthorized(sent);
        expect(sent.body, isNull);
      });
    });

    group('createBuild', () {
      test('posts the build to the project', () async {
        final adapter = FakeHttpAdapter([
          const FakeResponse(201, {
            'type': 'turbo',
            'buildId': 'build-1',
            'buildUrl': 'https://widgetbook.io/builds/build-1',
          }),
        ]);

        await clientFor(adapter).createBuild(
          apiKey,
          project,
          VersionsMetadata(
            flutter: '3.44.1',
            widgetbook: '4.0.0',
            cli: '4.0.0',
          ),
          createBuildRequest,
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('$projectPath/builds'));
        expectAuthorized(request);
        expect(request.header('x-widgetbook_cli-version'), equals('4.0.0'));
        expectNoCredentialInBody(request);
        expect(
          request.body!.keys,
          orderedEquals([
            'versionControlProvider',
            'repository',
            'actor',
            'branch',
            'sha',
            'mergedResultSha',
            'stories',
            'expectedSnapshotCount',
            'size',
            'hash',
          ]),
        );
      });

      const errors = {
        403: 'This API key has no access to this project.',
        404: 'Project not found.',
        409: 'Build already exists',
      };

      for (final MapEntry(key: statusCode, value: detail) in errors.entries) {
        test('shows the server message of a $statusCode', () {
          final adapter = FakeHttpAdapter([
            FakeResponse(statusCode, {'message': detail}),
          ]);

          expect(
            clientFor(
              adapter,
            ).createBuild(apiKey, project, null, createBuildRequest),
            throwsCloudException(statusCode, detail),
          );
        });
      }
    });

    group('appendSnapshots', () {
      test('posts the snapshots to the build', () async {
        final adapter = FakeHttpAdapter([
          const FakeResponse(201, {'inserted': 0}),
        ]);

        await clientFor(adapter).appendSnapshots(
          apiKey,
          project,
          VersionsMetadata(flutter: null, widgetbook: null, cli: '4.0.0'),
          'build-1',
          const AppendSnapshotsRequest(snapshots: []),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(
          request.uri.path,
          equals('$projectPath/builds/build-1/snapshots'),
        );
        expectAuthorized(request);
        expect(request.header('x-widgetbook_cli-version'), equals('4.0.0'));
        expect(request.body, equals({'snapshots': <dynamic>[]}));
      });
    });

    group('submitBuild', () {
      test('posts to the submit route of the build without a body', () async {
        final adapter = FakeHttpAdapter([
          const FakeResponse(201, {
            'buildId': 'build-1',
            'buildUrl': 'https://widgetbook.io/builds/build-1',
          }),
        ]);

        final response = await clientFor(
          adapter,
        ).submitBuild(apiKey, project, 'build-1');

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('$projectPath/builds/build-1/submit'));
        expectAuthorized(request);
        expect(request.body, isNull);
        expect(
          response.buildUrl,
          equals('https://widgetbook.io/builds/build-1'),
        );
      });
    });

    group('skipReview', () {
      const skipResponse = FakeResponse(200, {
        'sha': headSha,
        'state': 'success',
        'prNumber': 123,
      });
      const noRetryDelays = [Duration.zero, Duration.zero, Duration.zero];
      const unknownPullRequest = FakeResponse(404, {
        'message':
            'No pull request #123 is known for this project. '
            'Widgetbook learns about pull requests from git-provider '
            'webhooks, so a freshly opened pull request may not have '
            'synchronized yet.',
      });

      test('posts the skip to the pull request of the project', () async {
        final adapter = FakeHttpAdapter([skipResponse]);

        await clientFor(adapter).skipReview(
          apiKey,
          project,
          123,
          const SkipReviewRequest(sha: headSha, reason: 'No UI changes'),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(
          request.uri.path,
          equals('$projectPath/pull-requests/123/review-skip'),
        );
        expectAuthorized(request);
        expect(
          request.body,
          equals({'sha': headSha, 'reason': 'No UI changes'}),
        );
      });

      test('retries while the pull request is not synced yet', () async {
        final adapter = FakeHttpAdapter([
          unknownPullRequest,
          unknownPullRequest,
          skipResponse,
        ]);

        final response = await clientFor(adapter).skipReview(
          apiKey,
          project,
          123,
          const SkipReviewRequest(sha: headSha),
          retryDelays: noRetryDelays,
        );

        expect(response.prNumber, equals(123));
        expect(adapter.requests, hasLength(3));
      });

      test('gives up after the last retry', () async {
        final adapter = FakeHttpAdapter([unknownPullRequest]);

        await expectLater(
          clientFor(adapter).skipReview(
            apiKey,
            project,
            123,
            const SkipReviewRequest(sha: headSha),
            retryDelays: noRetryDelays,
          ),
          throwsA(
            isA<CloudException>()
                .having((e) => e.statusCode, 'statusCode', 404)
                .having((e) => e.detail, 'detail', startsWith('No pull')),
          ),
        );

        expect(adapter.requests, hasLength(4));
      });

      const notRetried = [
        (400, 'Synthetic pull requests have no git-provider counterpart.'),
        (401, 'Invalid API key.'),
        (403, 'This API key lacks the scope REVIEWS_SKIP.'),
        (403, 'This API key has no access to this project.'),
        (404, 'Workspace not found.'),
        (404, 'Project not found.'),
        (422, 'Validation failed.'),
      ];

      for (final (statusCode, detail) in notRetried) {
        test('does not retry a $statusCode: $detail', () async {
          final adapter = FakeHttpAdapter([
            FakeResponse(statusCode, {'message': detail}),
            skipResponse,
          ]);

          await expectLater(
            clientFor(adapter).skipReview(
              apiKey,
              project,
              123,
              const SkipReviewRequest(sha: headSha),
              retryDelays: noRetryDelays,
            ),
            throwsCloudException(statusCode, detail),
          );

          expect(adapter.requests, hasLength(1));
        });
      }
    });
  });

  group('resolveProject', () {
    group('workspace', () {
      test('returns the one workspace of the key', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse(['my-app']),
        ]);

        final resolved = await resolve(adapter);

        expect(resolved.workspaceId, equals('workspace-1'));
      });

      for (final count in [0, 2]) {
        test('fails for $count workspaces', () {
          final adapter = FakeHttpAdapter([
            FakeResponse(200, {
              'workspaces': [
                for (var i = 0; i < count; i++)
                  {'id': 'workspace-$i', 'name': 'Workspace $i'},
              ],
            }),
          ]);

          expect(
            resolve(adapter),
            throwsCliException(
              'Expected the API key to belong to exactly one workspace, '
              'but Widgetbook Cloud returned $count.',
            ),
          );
        });
      }
    });

    group('project', () {
      test('looks the project up by name', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse(['my-app']),
        ]);

        final resolved = await resolve(adapter, name: 'my-app');

        expect(resolved.workspaceId, equals('workspace-1'));
        expect(resolved.projectId, equals('project-1'));
        expect(resolved.name, equals('my-app'));
        expect(resolved.path, equals(projectPath.substring(1)));

        final [workspaces, projects] = adapter.requests;
        expect(workspaces.uri.path, equals('/v4/workspaces'));
        expect(projects.method, equals('GET'));
        expect(
          projects.uri.path,
          equals('/v4/workspaces/workspace-1/projects'),
        );
        expect(projects.uri.queryParameters, equals({'name': 'my-app'}));
        for (final request in adapter.requests) {
          expectAuthorized(request);
        }
      });

      test('uses the only project without a name', () async {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse(['my-app']),
        ]);

        final resolved = await resolve(adapter);

        expect(resolved.projectId, equals('project-1'));
        expect(adapter.requests.last.uri.queryParameters, isEmpty);
      });

      test('points to project create for an unknown name', () {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse([]),
        ]);

        expect(
          resolve(adapter, name: 'my-app'),
          throwsCliException(
            "No project named 'my-app'. "
            'Create it with: widgetbook cloud project create --project my-app',
          ),
        );
      });

      test('quotes a name with spaces in the suggested command', () {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse([]),
        ]);

        expect(
          resolve(adapter, name: 'my app'),
          throwsCliException(
            "No project named 'my app'. "
            'Create it with: '
            'widgetbook cloud project create --project "my app"',
          ),
        );
      });

      test('fails without a name when the key reaches no project', () {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse([]),
        ]);

        expect(
          resolve(adapter),
          throwsCliException(
            'This API key reaches no project. Create one with: '
            'widgetbook cloud project create --project <name>',
          ),
        );
      });

      test('asks for a name when the key reaches several projects', () {
        final adapter = FakeHttpAdapter([
          workspacesResponse,
          projectsResponse(['a', 'b']),
        ]);

        expect(
          resolve(adapter),
          throwsCliException(
            'This API key reaches 2 projects. '
            'Pass --project <name> to choose one.',
          ),
        );
      });

      test('does not look up projects without a workspace', () async {
        final adapter = FakeHttpAdapter([
          const FakeResponse(200, {'workspaces': <dynamic>[]}),
        ]);

        await expectLater(
          resolve(adapter, name: 'my-app'),
          throwsA(isA<CliException>()),
        );

        expect(adapter.requests, hasLength(1));
      });
    });
  });
}
