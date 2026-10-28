import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/fake_http_adapter.dart';
import '../../helper/mocks.dart';

const _headSha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';

typedef _CloudCommand = ({
  String name,
  List<String> args,
  CliCommand<Object?> Function(
    Context context,
    Logger logger,
    WidgetbookHttpClient client,
  )
  create,
});

final _commands = <_CloudCommand>[
  (
    name: 'cloud build push',
    args: ['--api-key', 'key', '--actor', 'actor', '--repository', 'app'],
    create: (context, logger, client) {
      final processManager = MockProcessManager();
      when(
        () => processManager.run(
          any<List<String>>(),
          workingDirectory: any(named: 'workingDirectory'),
          runInShell: any(named: 'runInShell'),
        ),
      ).thenAnswer((_) async => MockProcessResult.success('Flutter 3.24.0'));

      final cacheReader = MockCacheReader();
      when(
        () => cacheReader.read(any()),
      ).thenAnswer((_) async => const CacheStore.empty());

      return BuildPushCommand(
        context: context,
        logger: logger,
        fileSystem: MemoryFileSystem(),
        processManager: processManager,
        cacheReader: cacheReader,
        cloudClient: client,
      );
    },
  ),
  (
    name: 'cloud review skip',
    args: ['--api-key', 'key', '--pr', '123', '--sha', _headSha],
    create: (context, logger, client) => ReviewSkipCommand(
      context: context,
      logger: logger,
      cloudClient: client,
    ),
  ),
];

void main() {
  late Context context;
  late Logger logger;

  setUp(() {
    final repository = MockRepository();
    when(() => repository.currentBranch).thenAnswer(
      (_) async => const Reference(_headSha, 'refs/heads/main'),
    );

    context = MockContext();
    when(() => context.repository).thenReturn(repository);
    when(() => context.name).thenReturn('github');

    logger = MockLogger();
    when(() => logger.progress(any())).thenReturn(MockProgress());
  });

  for (final command in _commands) {
    group(command.name, () {
      test('shows --api-url in the usage', () {
        final usage = command
            .create(context, logger, WidgetbookHttpClient())
            .argParser
            .usage;

        expect(usage, contains('--api-url'));
        expect(usage, contains('https://api.widgetbook.io/'));
      });

      test('applies --api-url to its cloud client', () async {
        final dio = Dio(BaseOptions(baseUrl: BASE_API_URL))
          ..httpClientAdapter = FakeHttpAdapter([
            const FakeResponse(200, {
              'sha': _headSha,
              'state': 'success',
              'prNumber': 123,
            }),
          ]);
        final client = WidgetbookHttpClient(client: dio);
        final cliCommand = command.create(context, logger, client);

        final runner = CommandRunner<int>('test', 'test')
          ..addCommand(cliCommand);

        await runner.run([
          cliCommand.name,
          ...command.args,
          ...['--api-url', 'https://host'],
        ]);

        expect(client.baseUrl, equals(Uri.parse('https://host/')));
      });
    });
  }
}
