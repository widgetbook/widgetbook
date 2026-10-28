import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';

const _response = FakeResponse(200, {
  'type': 'turbo',
  'buildId': 'build-1',
  'buildUrl': 'https://host/builds/build-1',
  'inserted': 1,
  'sha': '832e76a9899f560a90ffd62ae2ce83bbeff58f54',
  'state': 'success',
  'prNumber': 123,
});

void main() {
  group('$WidgetbookHttpClient', () {
    late FakeHttpAdapter adapter;

    WidgetbookHttpClient clientFor(Uri? baseUrl) {
      final dio = Dio(BaseOptions(baseUrl: BASE_API_URL))
        ..httpClientAdapter = adapter;

      return WidgetbookHttpClient(client: dio, baseUrl: baseUrl);
    }

    Future<List<Uri>> requestAll(WidgetbookHttpClient client) async {
      await client.createBuild(
        null,
        const CreateBuildRequest(
          apiKey: 'key',
          versionControlProvider: 'github',
          repository: 'widgetbook/app',
          actor: 'actor',
          branch: 'main',
          sha: 'sha',
          mergedResultSha: null,
          stories: [],
          expectedSnapshotCount: 0,
          size: 0,
          hash: null,
        ),
      );
      await client.appendSnapshots(
        null,
        'build-1',
        const AppendSnapshotsRequest(apiKey: 'key', snapshots: []),
      );
      await client.submitBuild(
        const SubmitBuildRequest(apiKey: 'key', buildId: 'build-1'),
      );
      await client.skipReview(
        123,
        const SkipReviewRequest(apiKey: 'key', sha: 'sha'),
      );

      return adapter.requests.map((request) => request.uri).toList();
    }

    setUp(() {
      adapter = FakeHttpAdapter([_response]);
    });

    test('requests the default API URL', () async {
      final uris = await requestAll(clientFor(null));

      expect(
        uris.first,
        equals(Uri.parse('https://api.widgetbook.io/v4/builds')),
      );
    });

    for (final (base, expected) in [
      ('https://host', 'https://host'),
      ('https://host/', 'https://host'),
      ('https://host/api', 'https://host/api'),
      ('https://host/api/', 'https://host/api'),
      ('http://localhost:3000', 'http://localhost:3000'),
    ]) {
      test('requests the API below $base', () async {
        final uris = await requestAll(clientFor(Uri.parse(base)));

        expect(
          uris,
          equals([
            Uri.parse('$expected/v4/builds'),
            Uri.parse('$expected/v4/builds/build-1/snapshots'),
            Uri.parse('$expected/v4/builds/submit'),
            Uri.parse('$expected/v4/pull-requests/123/review-skip'),
          ]),
        );
      });
    }
  });
}
