import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';
import '../../helper/mocks.dart';

final _scenario = ScenarioRecord(
  component: const ComponentMetadata(name: 'Button', path: 'widgets/button'),
  story: const StoryMetadata(name: 'Default', designLink: null),
  scenario: ScenarioMetadata(
    name: 'light',
    path: 'widgets/button/Button/Default/light',
    modes: {},
    args: {},
  ),
  image: const ImageMetadata(
    path: '.widgetbook/snapshots/aaaa1111.png',
    hash: 'aaaa1111',
    size: 1024,
    width: 10,
    height: 10,
    pixelRatio: 1,
  ),
  semantics: {'hash': 'aaaa1111'},
);

void main() {
  group('$BuildPushCommand', () {
    late Logger logger;
    late Repository repository;
    late Progress progress;
    late Context context;

    setUp(() async {
      logger = MockLogger();
      repository = MockRepository();
      progress = MockProgress();
      context = MockContext();

      when(() => logger.progress(any<String>())).thenReturn(progress);

      when(() => context.repository).thenReturn(repository);
    });

    group('api-url', () {
      test('is shown in the usage', () {
        final command = BuildPushCommand(context: context);

        expect(command.argParser.options['api-url']!.hide, isFalse);
        expect(command.argParser.usage, contains('--api-url'));
        expect(command.argParser.usage, contains('https://api.widgetbook.io/'));
      });

      for (final url in [
        'https://api.example.com',
        'https://api.example.com/',
      ]) {
        test('requests the API below $url', () async {
          final adapter = FakeHttpAdapter([
            const FakeResponse(200, {
              'type': 'turbo',
              'buildId': 'build-1',
              'buildUrl': 'https://api.example.com/builds/build-1',
            }),
          ]);
          final dio = Dio(BaseOptions(baseUrl: BASE_API_URL))
            ..httpClientAdapter = adapter;

          final fileSystem = MemoryFileSystem()
            ..directory('/project/build/web').createSync(recursive: true);
          final processManager = MockProcessManager();
          when(
            () => processManager.run(
              any<List<String>>(),
              workingDirectory: any(named: 'workingDirectory'),
              runInShell: any(named: 'runInShell'),
            ),
          ).thenAnswer(
            (_) async => MockProcessResult.success('Flutter 3.24.0'),
          );
          final cacheReader = MockCacheReader();
          when(() => cacheReader.read(any())).thenAnswer(
            (_) async => CacheStore(scenarios: [_scenario]),
          );
          when(() => context.name).thenReturn('github');
          when(() => repository.currentBranch).thenAnswer(
            (_) async => const Reference('sha', 'refs/heads/main'),
          );

          final runner = CommandRunner<int>('test', 'test')
            ..addCommand(
              BuildPushCommand(
                context: context,
                logger: logger,
                fileSystem: fileSystem,
                processManager: processManager,
                cacheReader: cacheReader,
                cloudClient: WidgetbookHttpClient(client: dio),
              ),
            );

          final exitCode = await runner.run([
            'push',
            ...['--api-key', 'key', '--path', '/project'],
            ...['--actor', 'actor', '--repository', 'widgetbook/app'],
            ...['--api-url', url],
          ]);

          expect(exitCode, equals(ExitCode.success.code));
          expect(
            adapter.requests.single.uri,
            equals(Uri.parse('https://api.example.com/v4/builds')),
          );
        });
      }

      for (final url in [
        'api.widgetbook.io',
        'ftp://x',
        'https://',
        'https://host/?x',
      ]) {
        test('rejects $url as a usage error', () async {
          final runner = CliRunner(
            context: context,
            logger: logger,
            pubUpdater: MockPubUpdater(),
          );

          final exitCode = await runner.run([
            'cloud',
            'build',
            'push',
            ...['--api-key', 'key', '--api-url', url],
          ]);

          expect(exitCode, equals(ExitCode.usage.code));
          verify(
            () => logger.err(
              'The --api-url option must be an http or https URL, '
              'got "$url".',
            ),
          ).called(1);
        });
      }
    });

    group('parseResults', () {
      late ArgResults results;
      late BuildPushCommand command;

      setUp(() {
        results = MockArgResults();
        command = BuildPushCommand(
          context: context,
        );

        // Default ArgResults
        when(() => results['path']).thenReturn('default path');
        when(() => results['api-key']).thenReturn('default key');
        when(() => results['no-turbo']).thenReturn(true);
        when(() => results['allow-existing']).thenReturn(false);

        // Default Context
        when(() => context.name).thenReturn('default');
        when(() => context.user).thenReturn('default user');
        when(() => context.project).thenReturn('default repo');
        when(() => context.providerSha).thenReturn('default sha');
        when(() => context.repository).thenReturn(repository);

        // Default Repository
        when(() => repository.currentBranch).thenAnswer(
          (_) async => const Reference(
            'default sha',
            'refs/default/branch',
          ),
        );
      });

      test('path', () async {
        const path = 'root/path/to/project';
        when(() => results['path']).thenReturn(path);

        final args = await command.parseResults(context, results);

        expect(args.path, equals(path));
      });

      test('apiKey', () async {
        const apiKey = 'SeCrEtKeY';
        when(() => results['api-key']).thenReturn(apiKey);

        final args = await command.parseResults(context, results);

        expect(args.apiKey, equals(apiKey));
      });

      group('actor', () {
        test('from $ArgResults', () async {
          const userName = 'John Doe';
          when(() => results['actor']).thenReturn(userName);

          final args = await command.parseResults(context, results);

          expect(args.actor, equals(userName));
        });

        test('from $Context', () async {
          const userName = 'John Doe';
          when(() => results['actor']).thenReturn(null);
          when(() => context.user).thenReturn(userName);

          final args = await command.parseResults(context, results);

          expect(args.actor, equals(userName));
        });

        test('throws $MissingOptionException', () async {
          when(() => results['actor']).thenReturn(null);
          when(() => context.user).thenReturn(null);

          expectLater(
            () => command.parseResults(context, results),
            throwsA(
              isA<MissingOptionException>().having(
                (e) => e.option,
                'option',
                equals('actor'),
              ),
            ),
          );
        });
      });

      group('repository', () {
        test('from $ArgResults', () async {
          const repoName = 'widgetbook';
          when(() => results['repository']).thenReturn(repoName);

          final args = await command.parseResults(context, results);

          expect(args.repository, equals(repoName));
        });

        test('from $Context', () async {
          const repoName = 'widgetbook';
          when(() => results['repository']).thenReturn(null);
          when(() => context.project).thenReturn(repoName);

          final args = await command.parseResults(context, results);

          expect(args.repository, equals(repoName));
        });

        test('throws $MissingOptionException', () async {
          when(() => results['repository']).thenReturn(null);
          when(() => context.project).thenReturn(null);

          expectLater(
            () => command.parseResults(context, results),
            throwsA(
              isA<MissingOptionException>().having(
                (e) => e.option,
                'option',
                equals('repository'),
              ),
            ),
          );
        });

        group('branch', () {
          test('from $ArgResults', () async {
            const branch = 'main';
            when(() => results['branch']).thenReturn(branch);

            final args = await command.parseResults(context, results);
            ;

            expect(args.branch, equals(branch));
          });

          test('from $Repository', () async {
            const branch = 'main';
            when(() => results['branch']).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => const Reference(
                '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf',
                'refs/heads/$branch',
              ),
            );

            final args = await command.parseResults(context, results);
            ;

            expect(args.branch, equals(branch));
          });
        });

        group('commit', () {
          test('from $ArgResults', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(commit);

            final args = await command.parseResults(context, results);
            ;

            expect(args.commit, equals(commit));
          });

          test('from $Context', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(null);
            when(() => context.providerSha).thenReturn(commit);

            final args = await command.parseResults(context, results);
            ;

            expect(args.commit, equals(commit));
          });

          test('from $Repository', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(null);
            when(() => context.providerSha).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => const Reference(
                commit,
                'refs/heads/main',
              ),
            );

            final args = await command.parseResults(context, results);
            ;

            expect(args.commit, equals(commit));
          });
        });
      });
    });
  });
}
