import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

void main() {
  final component = const ComponentMetadata(
    name: 'Button',
    path: 'widgets/button',
  );
  final story = const StoryMetadata(
    name: 'Default',
    designLink: 'https://figma.com/x',
  );
  final scenario = ScenarioMetadata(
    name: 'Default (light)',
    path: 'widgets/button/Default/light',
    modes: const {
      'theme': {'brightness': 'light'},
    },
    args: const {
      'group': {'label': 'Click'},
    },
  );
  final image = const ImageMetadata(
    path: '.widgetbook/snapshots/abc.png',
    hash: 'abc123',
    size: 4096,
    width: 100,
    height: 50,
    pixelRatio: 2.0,
  );

  group('$StoryRecord', () {
    test('toJson matches server StoryRecord keys', () {
      final record = StoryRecord(
        component: component,
        story: story,
        navPath: 'widgets/button/Button/Default',
        knobsConfigs: const {
          'group': {'label': 'Click'},
        },
      );

      final json = record.toJson();

      expect(
        json.keys,
        containsAll(<String>['component', 'story', 'navPath', 'knobsConfigs']),
      );
      expect(json['navPath'], equals('widgets/button/Button/Default'));
      expect(json['component'], equals(component.toJson()));
      expect(json['story'], equals(story.toJson()));
      expect(
        json['knobsConfigs'],
        equals(const {
          'group': {'label': 'Click'},
        }),
      );
    });

    test('toJson sends null knobsConfigs when omitted', () {
      final record = StoryRecord(
        component: component,
        story: story,
        navPath: 'widgets/button/Button/Default',
      );

      expect(record.toJson()['knobsConfigs'], isNull);
    });
  });

  group('$SnapshotRecord', () {
    test('toJson matches server SnapshotRecord keys', () {
      final record = SnapshotRecord(
        scenario: scenario,
        image: image,
        navPath: 'widgets/button/Button/Default',
        semantics: const {'role': 'button'},
      );

      final json = record.toJson();

      expect(
        json.keys,
        containsAll(<String>['scenario', 'image', 'navPath', 'semantics']),
      );
      // navPath is the OWNING STORY navPath, NOT the scenario path.
      expect(json['navPath'], equals('widgets/button/Button/Default'));
      expect(json['navPath'], isNot(equals(scenario.path)));
      expect(json['scenario'], equals(scenario.toJson()));
      expect(json['image'], equals(image.toJson()));
      expect(json['semantics'], equals(const {'role': 'button'}));
    });
  });

  group('$AppendSnapshotsRequest', () {
    test('toJson matches server AppendSnapshotsV4RequestDto keys', () {
      final request = AppendSnapshotsRequest(
        apiKey: 'key',
        snapshots: [
          SnapshotRecord(
            scenario: scenario,
            image: image,
            navPath: 'widgets/button/Button/Default',
            semantics: const {},
          ),
        ],
      );

      final json = request.toJson();

      expect(json.keys, containsAll(<String>['apiKey', 'snapshots']));
      expect(json['apiKey'], equals('key'));
      expect(json['snapshots'], isA<List<dynamic>>());
      expect((json['snapshots'] as List).length, equals(1));
    });
  });

  group('$AppendSnapshotsResponse', () {
    test('fromJson reads inserted count', () {
      final response = AppendSnapshotsResponse.fromJson(const {'inserted': 7});
      expect(response.inserted, equals(7));
    });
  });

  group('$CreateBuildRequest (batched)', () {
    test('toJson sends stories + expectedSnapshotCount, not scenarios', () {
      final request = CreateBuildRequest(
        apiKey: 'key',
        versionControlProvider: 'github',
        repository: 'widgetbook/app',
        actor: 'jens',
        branch: 'main',
        sha: 'deadbeef',
        mergedResultSha: null,
        stories: [
          StoryRecord(
            component: component,
            story: story,
            navPath: 'widgets/button/Button/Default',
          ),
        ],
        expectedSnapshotCount: 3,
        size: 1234,
        hash: null,
      );

      final json = request.toJson();

      expect(json.containsKey('scenarios'), isFalse);
      expect(json['stories'], isA<List<dynamic>>());
      expect((json['stories'] as List).length, equals(1));
      expect(json['expectedSnapshotCount'], equals(3));
      // Header fields preserved.
      expect(json['apiKey'], equals('key'));
      expect(json['versionControlProvider'], equals('github'));
      expect(json['repository'], equals('widgetbook/app'));
      expect(json['actor'], equals('jens'));
      expect(json['branch'], equals('main'));
      expect(json['sha'], equals('deadbeef'));
      expect(json['mergedResultSha'], isNull);
      expect(json['size'], equals(1234));
      expect(json['hash'], isNull);
    });
  });

  group('$ScenarioRecord.storyNavPath', () {
    test('equals component.path / component.name / story.name', () {
      final record = ScenarioRecord(
        component: component,
        story: story,
        scenario: scenario,
        image: image,
        semantics: const {},
      );

      expect(record.storyNavPath, equals('widgets/button/Button/Default'));
    });
  });
}
