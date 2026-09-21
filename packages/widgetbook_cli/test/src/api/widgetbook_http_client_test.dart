import 'package:test/test.dart';
import 'package:widgetbook_cli/src/api/cloud_exception.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';

const projectKey = ProjectApiKey('project-key');
const workspaceKey = WorkspaceApiKey('widgetbook_ws_secret');
const headSha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';

WidgetbookHttpClient clientFor(FakeHttpAdapter adapter) {
  return WidgetbookHttpClient()..client.httpClientAdapter = adapter;
}

CreateBuildRequest createBuildRequest(ApiKey apiKey, {String? projectName}) {
  return CreateBuildRequest(
    apiKey: apiKey,
    versionControlProvider: 'GitHub',
    repository: 'widgetbook/app',
    actor: 'octocat',
    branch: 'main',
    sha: headSha,
    mergedResultSha: null,
    stories: const [],
    expectedSnapshotCount: 3,
    size: 1024,
    hash: null,
    projectName: projectName,
  );
}

Matcher throwsCloudException(int statusCode, String detail) {
  return throwsA(
    isA<CloudException>()
        .having((e) => e.statusCode, 'statusCode', statusCode)
        .having((e) => e.detail, 'detail', detail)
        .having((e) => e.message, 'message', contains(detail)),
  );
}

void main() {
  group('$WidgetbookHttpClient', () {
    group('createBuild', () {
      const turboResponse = FakeResponse(201, {
        'type': 'turbo',
        'buildId': 'build-1',
        'buildUrl': 'https://widgetbook.io/builds/build-1',
      });

      test('sends a project key in the body, as before', () async {
        final adapter = FakeHttpAdapter([turboResponse]);

        await clientFor(adapter).createBuild(
          VersionsMetadata(
            flutter: '3.44.1',
            widgetbook: '4.0.0',
            cli: '4.0.0',
          ),
          createBuildRequest(projectKey),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/builds'));
        expect(request.header('Authorization'), isNull);
        expect(request.header('x-widgetbook_cli-version'), equals('4.0.0'));
        expect(
          request.body!.keys,
          orderedEquals([
            'apiKey',
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
        expect(request.body!['apiKey'], equals('project-key'));
      });

      test('adds the projectName to a project key request', () async {
        final adapter = FakeHttpAdapter([turboResponse]);

        await clientFor(adapter).createBuild(
          null,
          createBuildRequest(projectKey, projectName: 'my-app'),
        );

        final request = adapter.requests.single;
        expect(request.header('Authorization'), isNull);
        expect(request.body!['apiKey'], equals('project-key'));
        expect(request.body!['projectName'], equals('my-app'));
      });

      test('sends a workspace key as a bearer token', () async {
        final adapter = FakeHttpAdapter([turboResponse]);

        await clientFor(adapter).createBuild(
          VersionsMetadata(flutter: null, widgetbook: null, cli: '4.0.0'),
          createBuildRequest(workspaceKey, projectName: 'my-app'),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/builds'));
        expect(
          request.header('Authorization'),
          equals('Bearer widgetbook_ws_secret'),
        );
        expect(request.header('x-widgetbook_cli-version'), equals('4.0.0'));
        expect(request.body, isNot(contains('apiKey')));
        expect(request.body!['projectName'], equals('my-app'));
      });

      for (final detail in ['Missing API key.', 'Invalid API key.']) {
        test('shows the server message of a 401: $detail', () {
          final adapter = FakeHttpAdapter([
            FakeResponse(401, {'message': detail, 'statusCode': 401}),
          ]);

          expect(
            clientFor(
              adapter,
            ).createBuild(null, createBuildRequest(projectKey)),
            throwsCloudException(401, detail),
          );
        });
      }
    });

    group('appendSnapshots', () {
      const appendResponse = FakeResponse(201, {'inserted': 0});

      test('sends a project key in the body, as before', () async {
        final adapter = FakeHttpAdapter([appendResponse]);

        await clientFor(adapter).appendSnapshots(
          null,
          'build-1',
          const AppendSnapshotsRequest(apiKey: projectKey, snapshots: []),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/builds/build-1/snapshots'));
        expect(request.header('Authorization'), isNull);
        expect(
          request.body,
          equals({'apiKey': 'project-key', 'snapshots': <dynamic>[]}),
        );
      });

      test('sends a workspace key as a bearer token only', () async {
        final adapter = FakeHttpAdapter([appendResponse]);

        await clientFor(adapter).appendSnapshots(
          null,
          'build-1',
          const AppendSnapshotsRequest(apiKey: workspaceKey, snapshots: []),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/builds/build-1/snapshots'));
        expect(
          request.header('Authorization'),
          equals('Bearer widgetbook_ws_secret'),
        );
        expect(request.body, equals({'snapshots': <dynamic>[]}));
      });
    });

    group('submitBuild', () {
      const submitResponse = FakeResponse(201, {
        'buildId': 'build-1',
        'buildUrl': 'https://widgetbook.io/builds/build-1',
      });

      test('sends a project key in the body, as before', () async {
        final adapter = FakeHttpAdapter([submitResponse]);

        await clientFor(adapter).submitBuild(
          const SubmitBuildRequest(apiKey: projectKey, buildId: 'build-1'),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/builds/submit'));
        expect(request.header('Authorization'), isNull);
        expect(
          request.body,
          equals({'apiKey': 'project-key', 'buildId': 'build-1'}),
        );
      });

      test('sends a workspace key as a bearer token only', () async {
        final adapter = FakeHttpAdapter([submitResponse]);

        await clientFor(adapter).submitBuild(
          const SubmitBuildRequest(apiKey: workspaceKey, buildId: 'build-1'),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/builds/submit'));
        expect(
          request.header('Authorization'),
          equals('Bearer widgetbook_ws_secret'),
        );
        expect(request.body, equals({'buildId': 'build-1'}));
      });
    });

    group('skipReview', () {
      const skipResponse = FakeResponse(201, {
        'sha': headSha,
        'state': 'success',
        'prNumber': 123,
      });
      const noRetryDelays = [Duration.zero, Duration.zero, Duration.zero];

      test('sends a project key in the body, as before', () async {
        final adapter = FakeHttpAdapter([skipResponse]);

        await clientFor(adapter).skipReview(
          123,
          const SkipReviewRequest(
            apiKey: projectKey,
            sha: headSha,
            reason: 'No UI changes',
          ),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/pull-requests/123/review-skip'));
        expect(request.header('Authorization'), isNull);
        expect(
          request.body,
          equals({
            'apiKey': 'project-key',
            'sha': headSha,
            'reason': 'No UI changes',
          }),
        );
      });

      test('adds the projectName to a project key request', () async {
        final adapter = FakeHttpAdapter([skipResponse]);

        await clientFor(adapter).skipReview(
          123,
          const SkipReviewRequest(
            apiKey: projectKey,
            sha: headSha,
            projectName: 'my-app',
          ),
        );

        final request = adapter.requests.single;
        expect(request.header('Authorization'), isNull);
        expect(
          request.body,
          equals({
            'apiKey': 'project-key',
            'sha': headSha,
            'projectName': 'my-app',
          }),
        );
      });

      test('sends a workspace key as a bearer token', () async {
        final adapter = FakeHttpAdapter([skipResponse]);

        await clientFor(adapter).skipReview(
          123,
          const SkipReviewRequest(
            apiKey: workspaceKey,
            sha: headSha,
            projectName: 'my-app',
          ),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/pull-requests/123/review-skip'));
        expect(
          request.header('Authorization'),
          equals('Bearer widgetbook_ws_secret'),
        );
        expect(
          request.body,
          equals({'sha': headSha, 'projectName': 'my-app'}),
        );
      });

      test('retries while the pull request is unknown', () async {
        final adapter = FakeHttpAdapter([
          const FakeResponse(404, {'message': 'Pull request not found.'}),
          const FakeResponse(404, {'message': 'Pull request not found.'}),
          skipResponse,
        ]);

        final response = await clientFor(adapter).skipReview(
          123,
          const SkipReviewRequest(apiKey: workspaceKey, sha: headSha),
          retryDelays: noRetryDelays,
        );

        expect(response.prNumber, equals(123));
        expect(adapter.requests, hasLength(3));
      });

      const notRetried = {
        400: 'A workspace API key must name the project: provide projectName.',
        401: 'Invalid API key.',
        422: "No project named 'my-app' in this workspace.",
      };

      for (final MapEntry(key: statusCode, value: detail)
          in notRetried.entries) {
        test('does not retry a $statusCode', () async {
          final adapter = FakeHttpAdapter([
            FakeResponse(statusCode, {'message': detail}),
            skipResponse,
          ]);

          await expectLater(
            clientFor(adapter).skipReview(
              123,
              const SkipReviewRequest(
                apiKey: workspaceKey,
                sha: headSha,
                projectName: 'my-app',
              ),
              retryDelays: noRetryDelays,
            ),
            throwsCloudException(statusCode, detail),
          );

          expect(adapter.requests, hasLength(1));
        });
      }
    });

    group('createProject', () {
      test('creates the project with a workspace key', () async {
        final adapter = FakeHttpAdapter([
          const FakeResponse(201, {
            'id': 'project-1',
            'name': 'my-app',
            'createdAt': '2026-01-02T03:04:05.000Z',
          }),
        ]);

        final response = await clientFor(adapter).createProject(
          const CreateProjectRequest(apiKey: workspaceKey, name: 'my-app'),
        );

        final request = adapter.requests.single;
        expect(request.method, equals('POST'));
        expect(request.uri.path, equals('/v4/projects'));
        expect(
          request.header('Authorization'),
          equals('Bearer widgetbook_ws_secret'),
        );
        expect(request.body, equals({'name': 'my-app'}));

        expect(response.id, equals('project-1'));
        expect(response.name, equals('my-app'));
        expect(response.createdAt, equals(DateTime.utc(2026, 1, 2, 3, 4, 5)));
      });

      test('reports an existing project as a 409', () {
        const detail =
            'A project with this name already exists in this workspace.';
        final adapter = FakeHttpAdapter([
          const FakeResponse(409, {'message': detail, 'statusCode': 409}),
        ]);

        expect(
          clientFor(adapter).createProject(
            const CreateProjectRequest(apiKey: workspaceKey, name: 'my-app'),
          ),
          throwsCloudException(409, detail),
        );
      });
    });
  });
}
