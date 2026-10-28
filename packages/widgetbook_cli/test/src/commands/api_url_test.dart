import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/commands/cloud_options.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

const _requestPaths = [
  'v4/builds',
  'v4/builds/build-1/snapshots',
  'v4/builds/submit',
  'v4/pull-requests/123/review-skip',
];

const _invalidUrls = [
  'api.widgetbook.io',
  'ftp://x',
  'https://',
  'https://host/?x',
];

String _errorFor(String url) =>
    'The --api-url option must be an http or https URL, got "$url".';

List<Uri> _requestedUris(WidgetbookHttpClient client) => [
  for (final path in _requestPaths)
    RequestOptions(baseUrl: client.client.options.baseUrl, path: path).uri,
];

/// Runs [args] against mocked dependencies, which fail the run once the
/// command reaches its actual work.
Future<void> _runUntilMockedWorkFails(
  CommandRunner<int> runner,
  List<String> args,
) async {
  try {
    await runner.run(args);
  } on Object catch (_) {}
}

typedef _CloudCommand = ({
  List<String> path,
  List<String> args,
  CliCommand<Object?> Function(Context, WidgetbookHttpClient) create,
});

final _cloudCommands = <_CloudCommand>[
  (
    path: ['cloud', 'build', 'push'],
    args: ['--api-key', 'key'],
    create: (context, client) =>
        BuildPushCommand(context: context, cloudClient: client),
  ),
  (
    path: ['cloud', 'review', 'skip'],
    args: ['--api-key', 'key', '--pr', '123', '--sha', 'sha'],
    create: (context, client) =>
        ReviewSkipCommand(context: context, cloudClient: client),
  ),
];

void main() {
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

    for (final url in _invalidUrls) {
      test('rejects $url as a usage error', () {
        expect(
          () => parseApiUrlOption(parser.parse(['--api-url', url])),
          throwsA(
            isA<CliException>()
                .having((e) => e.exitCode, 'exitCode', ExitCode.usage.code)
                .having((e) => e.message, 'message', _errorFor(url)),
          ),
        );
      });
    }
  });

  group('$WidgetbookHttpClient.baseUrl', () {
    test('defaults to $BASE_API_URL', () {
      expect(
        _requestedUris(WidgetbookHttpClient()),
        equals([
          for (final path in _requestPaths)
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
          _requestedUris(client),
          equals([
            for (final path in _requestPaths) Uri.parse('$expected/$path'),
          ]),
        );
      });
    }
  });

  for (final command in _cloudCommands) {
    group(command.path.join(' '), () {
      late Context context;
      late MockWidgetbookHttpClient client;

      setUp(() {
        context = MockContext();
        client = MockWidgetbookHttpClient();
      });

      test('shows --api-url with its default in the usage', () {
        final usage = command.create(context, client).argParser.usage;

        expect(usage, contains('--api-url'));
        expect(usage, contains('https://api.widgetbook.io/'));
      });

      test('sets --api-url on its cloud client', () async {
        final cliCommand = command.create(context, client);
        final runner = CommandRunner<int>('test', 'test')
          ..addCommand(cliCommand);

        await _runUntilMockedWorkFails(runner, [
          cliCommand.name,
          ...command.args,
          ...['--api-url', 'https://host'],
        ]);

        verify(() => client.baseUrl = Uri.parse('https://host')).called(1);
      });

      for (final url in _invalidUrls) {
        test('exits with the usage code for --api-url $url', () async {
          final logger = MockLogger();
          final runner = CliRunner(
            context: context,
            logger: logger,
            pubUpdater: MockPubUpdater(),
          );

          final exitCode = await runner.run([
            ...command.path,
            ...command.args,
            ...['--api-url', url],
          ]);

          expect(exitCode, equals(ExitCode.usage.code));
          verify(() => logger.err(_errorFor(url))).called(1);
        });
      }
    });
  }
}
