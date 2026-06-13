import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

/// Builds a [ScenarioRecord] for the given component/story/scenario names.
/// Scenarios sharing the same component+story collapse into a single story.
ScenarioRecord _scenario({
  required String componentName,
  required String componentPath,
  required String storyName,
  required String scenarioName,
  required String imageHash,
}) {
  return ScenarioRecord(
    component: ComponentMetadata(name: componentName, path: componentPath),
    story: StoryMetadata(name: storyName, designLink: null),
    scenario: ScenarioMetadata(
      name: scenarioName,
      path: '$componentPath/$componentName/$storyName/$scenarioName',
      modes: const {},
      args: const {},
    ),
    image: ImageMetadata(
      path: '.widgetbook/snapshots/$imageHash.png',
      hash: imageHash,
      size: 1024,
      width: 10,
      height: 10,
      pixelRatio: 1.0,
    ),
    semantics: {'hash': imageHash},
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const SubmitBuildRequest(apiKey: 'k', buildId: 'b'),
    );
    registerFallbackValue(
      const CreateBuildRequest(
        apiKey: 'k',
        versionControlProvider: 'github',
        repository: 'r',
        actor: 'a',
        branch: 'b',
        sha: 's',
        mergedResultSha: null,
        stories: [],
        expectedSnapshotCount: 0,
        size: 0,
        hash: null,
      ),
    );
    registerFallbackValue(
      const AppendSnapshotsRequest(apiKey: 'k', snapshots: []),
    );
  });

  group('$BuildPushCommand runWith (batched draft flow)', () {
    late MockLogger logger;
    late MockProgress progress;
    late MockContext context;
    late MockWidgetbookHttpClient cloudClient;
    late MockStorageClient storageClient;
    late MockProcessManager processManager;
    late MockCacheReader cacheReader;
    late FileSystem fileSystem;
    late BuildPushCommand command;

    const draftResponse = CreateDraftBuildResponse(
      buildId: 'build-123',
      baseHref: '/builds/build-123/',
      storage: StorageInfo(url: 'https://s3/build', fields: {'key': 'k'}),
      snapshotStorage: StorageInfo(url: 'https://s3/snap', fields: {'key': 'k'}),
    );

    late List<ScenarioRecord> scenarios;

    BuildPushArgs makeArgs() => const BuildPushArgs(
          apiKey: 'api-key',
          path: '/project',
          branch: 'main',
          commit: 'sha-1',
          mergedResultCommit: null,
          vendor: 'github',
          actor: 'jens',
          repository: 'widgetbook/app',
          noTurbo: true,
        );

    setUp(() {
      logger = MockLogger();
      progress = MockProgress();
      context = MockContext();
      cloudClient = MockWidgetbookHttpClient();
      storageClient = MockStorageClient();
      processManager = MockProcessManager();
      cacheReader = MockCacheReader();
      fileSystem = MemoryFileSystem();

      when(() => logger.progress(any<String>())).thenReturn(progress);

      // Two scenarios share one story (Button/Default); a third is a
      // different story (Button/Disabled). => 2 unique stories, 3 snapshots.
      scenarios = [
        _scenario(
          componentName: 'Button',
          componentPath: 'widgets/button',
          storyName: 'Default',
          scenarioName: 'light',
          imageHash: 'aaaa1111',
        ),
        _scenario(
          componentName: 'Button',
          componentPath: 'widgets/button',
          storyName: 'Default',
          scenarioName: 'dark',
          imageHash: 'bbbb2222',
        ),
        _scenario(
          componentName: 'Button',
          componentPath: 'widgets/button',
          storyName: 'Disabled',
          scenarioName: 'light',
          imageHash: 'cccc3333',
        ),
      ];

      // build/web with a couple of files (incl. index.html for base-href).
      final buildDir = fileSystem.directory('/project/build/web')
        ..createSync(recursive: true);
      buildDir.childFile('index.html').writeAsStringSync('<base href="/">');
      buildDir.childFile('main.dart.js').writeAsStringSync('console.log(1)');

      // pubspec.lock for VersionsMetadata.from (may parse or fall back to null).
      fileSystem.file('/project/pubspec.lock').writeAsStringSync(
        'packages:\n'
        '  widgetbook:\n'
        '    version: "4.0.0"\n',
      );

      // Image files referenced by the snapshots.
      for (final scenario in scenarios) {
        fileSystem.file('/project/${scenario.image.path}')
          ..createSync(recursive: true)
          ..writeAsStringSync('png-bytes');
      }

      when(() => processManager.run(
            any<List<String>>(),
            workingDirectory: any(named: 'workingDirectory'),
            runInShell: any(named: 'runInShell'),
          )).thenAnswer(
        (_) async => MockProcessResult.success('Flutter 3.24.0'),
      );

      when(() => cacheReader.read(any<String>())).thenAnswer(
        (_) async => CacheStore(scenarios: scenarios),
      );

      when(() => cloudClient.createBuild(any(), any())).thenAnswer(
        (_) async => draftResponse,
      );
      when(() => cloudClient.appendSnapshots(any(), any<String>(), any()))
          .thenAnswer((_) async => const AppendSnapshotsResponse(inserted: 1));
      when(() => cloudClient.submitBuild(any())).thenAnswer(
        (_) async => const SubmitBuildResponse(
          buildId: 'build-123',
          buildUrl: 'https://widgetbook.io/builds/build-123',
        ),
      );
      when(() => storageClient.uploadObjects(any(), any(), any()))
          .thenAnswer((_) async {});

      command = BuildPushCommand(
        context: context,
        cloudClient: cloudClient,
        storageClient: storageClient,
        processManager: processManager,
        fileSystem: fileSystem,
        cacheReader: cacheReader,
        logger: logger,
      );
    });

    test('createBuild gets deduped stories + expectedSnapshotCount', () async {
      final exitCode = await command.runWith(context, makeArgs());

      expect(exitCode, equals(0));

      final captured = verify(
        () => cloudClient.createBuild(any(), captureAny()),
      ).captured.single as CreateBuildRequest;

      // 3 scenarios collapse into 2 unique stories.
      expect(captured.stories.length, equals(2));
      expect(captured.expectedSnapshotCount, equals(3));

      final navPaths = captured.stories.map((s) => s.navPath).toSet();
      expect(
        navPaths,
        equals({
          'widgets/button/Button/Default',
          'widgets/button/Button/Disabled',
        }),
      );
    });

    test('appendSnapshots receives all snapshots with OWNING-STORY navPath',
        () async {
      await command.runWith(context, makeArgs());

      final batches = verify(
        () => cloudClient.appendSnapshots(
          any(),
          'build-123',
          captureAny(),
        ),
      ).captured.cast<AppendSnapshotsRequest>();

      final allSnapshots =
          batches.expand((batch) => batch.snapshots).toList();

      // Every snapshot is appended.
      expect(allSnapshots.length, equals(3));

      // Snapshot navPath == owning story navPath (NOT scenario.path).
      for (final snapshot in allSnapshots) {
        expect(
          snapshot.navPath,
          anyOf(
            'widgets/button/Button/Default',
            'widgets/button/Button/Disabled',
          ),
        );
        expect(snapshot.navPath, isNot(contains('/light')));
        expect(snapshot.navPath, isNot(contains('/dark')));
      }

      // Two of the snapshots belong to the Default story, one to Disabled.
      final defaultCount = allSnapshots
          .where((s) => s.navPath == 'widgets/button/Button/Default')
          .length;
      expect(defaultCount, equals(2));
    });

    test('submit is called after create + append', () async {
      await command.runWith(context, makeArgs());

      verify(() => cloudClient.submitBuild(any())).called(1);
    });
  });

  group('$BuildPushCommand runWith (turbo flow)', () {
    late MockLogger logger;
    late MockProgress progress;
    late MockContext context;
    late MockWidgetbookHttpClient cloudClient;
    late MockStorageClient storageClient;
    late MockProcessManager processManager;
    late MockCacheReader cacheReader;
    late FileSystem fileSystem;
    late BuildPushCommand command;

    setUp(() {
      logger = MockLogger();
      progress = MockProgress();
      context = MockContext();
      cloudClient = MockWidgetbookHttpClient();
      storageClient = MockStorageClient();
      processManager = MockProcessManager();
      cacheReader = MockCacheReader();
      fileSystem = MemoryFileSystem();

      when(() => logger.progress(any<String>())).thenReturn(progress);

      final scenarios = [
        _scenario(
          componentName: 'Button',
          componentPath: 'widgets/button',
          storyName: 'Default',
          scenarioName: 'light',
          imageHash: 'aaaa1111',
        ),
      ];

      fileSystem.directory('/project/build/web')
        ..createSync(recursive: true)
        ..childFile('index.html').writeAsStringSync('<base href="/">');

      when(() => cacheReader.read(any<String>())).thenAnswer(
        (_) async => CacheStore(scenarios: scenarios),
      );
      when(() => processManager.run(
            any<List<String>>(),
            workingDirectory: any(named: 'workingDirectory'),
            runInShell: any(named: 'runInShell'),
          )).thenAnswer(
        (_) async => MockProcessResult.success('Flutter 3.24.0'),
      );
      when(() => cloudClient.createBuild(any(), any())).thenAnswer(
        (_) async => const CreateTurboBuildResponse(
          buildId: 'turbo-1',
          buildUrl: 'https://widgetbook.io/builds/turbo-1',
        ),
      );

      command = BuildPushCommand(
        context: context,
        cloudClient: cloudClient,
        storageClient: storageClient,
        processManager: processManager,
        fileSystem: fileSystem,
        cacheReader: cacheReader,
        logger: logger,
      );
    });

    test('turbo response does NOT append or upload or submit', () async {
      final exitCode = await command.runWith(
        context,
        const BuildPushArgs(
          apiKey: 'api-key',
          path: '/project',
          branch: 'main',
          commit: 'sha-1',
          mergedResultCommit: null,
          vendor: 'github',
          actor: 'jens',
          repository: 'widgetbook/app',
          noTurbo: true,
        ),
      );

      expect(exitCode, equals(0));
      verifyNever(
        () => cloudClient.appendSnapshots(any(), any<String>(), any()),
      );
      verifyNever(() => storageClient.uploadObjects(any(), any(), any()));
      verifyNever(() => cloudClient.submitBuild(any()));
    });
  });
}
