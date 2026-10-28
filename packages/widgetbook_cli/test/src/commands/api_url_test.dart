import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/commands/cloud_options.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

class _FakeCreateBuildRequest extends Fake implements CreateBuildRequest {}

class _FakeSkipReviewRequest extends Fake implements SkipReviewRequest {}

void main() {
  const headSha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
  const requestPaths = [
    'v4/builds',
    'v4/builds/build-1/snapshots',
    'v4/builds/submit',
    'v4/pull-requests/123/review-skip',
  ];
  const invalidUrls = [
    'api.widgetbook.io',
    'ftp://x',
    'https://',
    'https://host/?x',
  ];

  String errorFor(String url) =>
      'The --api-url option must be an http or https URL, got "$url".';

  setUpAll(() {
    registerFallbackValue(_FakeCreateBuildRequest());
    registerFallbackValue(_FakeSkipReviewRequest());
  });

  group('parseApiUrlOption', () {
    late ArgParser parser;

    setUp(() {
      parser = ArgParser()..addApiUrlOption();
    });

    test('declares a visible option with the default in its help', () {
      final option = parser.options['api-url']!;

      expect(option.hide, isFalse);
      expect(
        option.help,
        equals(
          'Base URL of the Widgetbook Cloud API. '
          'Defaults to https://api.widgetbook.io/.',
        ),
      );
    });

    test('returns null when the option is absent', () {
      expect(parseApiUrlOption(parser.parse([])), isNull);
    });

    for (final url in [
      'https://host',
      'https://host/',
      'https://host/api',
      'http://localhost:3000',
    ]) {
      test('accepts $url', () {
        expect(
          parseApiUrlOption(parser.parse(['--api-url', url])),
          equals(Uri.parse(url)),
        );
      });
    }

    for (final url in invalidUrls) {
      test('throws $CliException for $url', () {
        expect(
          () => parseApiUrlOption(parser.parse(['--api-url', url])),
          throwsA(
            isA<CliException>()
                .having((e) => e.exitCode, 'exitCode', ExitCode.usage.code)
                .having((e) => e.message, 'message', errorFor(url)),
          ),
        );
      });
    }
  });

  group('$WidgetbookHttpClient baseUrl', () {
    List<Uri> requestedUris(WidgetbookHttpClient client) => [
      for (final path in requestPaths)
        RequestOptions(baseUrl: client.client.options.baseUrl, path: path).uri,
    ];

    test('defaults to $BASE_API_URL', () {
      expect(
        requestedUris(WidgetbookHttpClient()),
        equals([
          for (final path in requestPaths)
            Uri.parse('https://api.widgetbook.io/$path'),
        ]),
      );
    });

    for (final (base, expected) in [
      ('https://host', 'https://host'),
      ('https://host/', 'https://host'),
      ('https://host/api', 'https://host/api'),
      ('https://host/api/', 'https://host/api'),
      ('http://localhost:3000', 'http://localhost:3000'),
    ]) {
      test('joins the request paths below $base', () {
        final client = WidgetbookHttpClient()..baseUrl = Uri.parse(base);

        expect(
          requestedUris(client),
          equals([
            for (final path in requestPaths) Uri.parse('$expected/$path'),
          ]),
        );
      });
    }
  });

  group('--api-url', () {
    late Logger logger;
    late Context context;
    late Repository repository;
    late MockWidgetbookHttpClient cloudClient;
    late MockProcessManager processManager;
    late MockCacheReader cacheReader;
    late MemoryFileSystem fileSystem;
    late CliRunner cliRunner;

    setUp(() {
      logger = MockLogger();
      context = MockContext();
      repository = MockRepository();
      cloudClient = MockWidgetbookHttpClient();
      processManager = MockProcessManager();
      cacheReader = MockCacheReader();
      fileSystem = MemoryFileSystem();

      when(() => logger.progress(any<String>())).thenReturn(MockProgress());

      when(() => context.name).thenReturn('github');
      when(() => context.user).thenReturn('John Doe');
      when(() => context.project).thenReturn('widgetbook');
      when(() => context.repository).thenReturn(repository);
      when(() => repository.currentBranch).thenAnswer(
        (_) async => const Reference(headSha, 'refs/heads/main'),
      );

      fileSystem.directory('/project/build/web').createSync(recursive: true);
      when(
        () => processManager.run(
          any<List<String>>(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        ),
      ).thenAnswer(
        (_) async => MockProcessResult.success('Flutter 3.24.0'),
      );
      when(() => cacheReader.read(any<String>())).thenAnswer(
        (_) async => CacheStore(
          scenarios: [
            ScenarioRecord(
              component: const ComponentMetadata(
                name: 'Button',
                path: 'widgets/button',
              ),
              story: const StoryMetadata(name: 'Default', designLink: null),
              scenario: ScenarioMetadata(
                name: 'light',
                path: 'widgets/button/Button/Default/light',
                modes: const {},
                args: const {},
              ),
              image: const ImageMetadata(
                path: '.widgetbook/snapshots/aaaa1111.png',
                hash: 'aaaa1111',
                size: 1024,
                width: 10,
                height: 10,
                pixelRatio: 1,
              ),
              semantics: const {'hash': 'aaaa1111'},
            ),
          ],
        ),
      );

      when(() => cloudClient.createBuild(any(), any())).thenAnswer(
        (_) async => const CreateTurboBuildResponse(
          buildId: 'turbo-1',
          buildUrl: 'https://host/builds/turbo-1',
        ),
      );
      when(() => cloudClient.skipReview(any(), any())).thenAnswer(
        (_) async => const SkipReviewResponse(
          sha: headSha,
          state: 'success',
          prNumber: 123,
        ),
      );

      cliRunner = CliRunner(
        context: context,
        logger: logger,
        pubUpdater: MockPubUpdater(),
      );
    });

    final commands = <(String, List<String>, CliCommand<Object?> Function())>[
      (
        'cloud build push',
        ['--api-key', 'key', '--path', '/project'],
        () => BuildPushCommand(
          context: context,
          logger: logger,
          cloudClient: cloudClient,
          processManager: processManager,
          fileSystem: fileSystem,
          cacheReader: cacheReader,
        ),
      ),
      (
        'cloud review skip',
        ['--api-key', 'key', '--pr', '123', '--sha', headSha],
        () => ReviewSkipCommand(
          context: context,
          logger: logger,
          cloudClient: cloudClient,
        ),
      ),
    ];

    for (final (name, args, buildCommand) in commands) {
      group('widgetbook $name', () {
        test('is shown in the usage', () {
          final command = buildCommand();

          expect(command.argParser.options['api-url']!.hide, isFalse);
          expect(command.argParser.usage, contains('--api-url'));
          expect(
            command.argParser.usage,
            contains('https://api.widgetbook.io/'),
          );
        });

        test('sets the base URL of the cloud client', () async {
          final command = buildCommand();
          final runner = CommandRunner<int>('widgetbook', '')
            ..addCommand(command);

          final result = await runner.run([
            command.name,
            ...args,
            ...['--api-url', 'https://host'],
          ]);

          expect(result, equals(ExitCode.success.code));
          verify(
            () => cloudClient.baseUrl = Uri.parse('https://host'),
          ).called(1);
        });

        for (final url in invalidUrls) {
          test('exits with the usage code for $url', () async {
            final result = await cliRunner.run([
              ...name.split(' '),
              ...args,
              ...['--api-url', url],
            ]);

            expect(result, equals(ExitCode.usage.code));
            verify(() => logger.err(errorFor(url))).called(1);
          });
        }
      });
    }
  });
}
