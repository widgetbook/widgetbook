import 'package:args/args.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/commands/cloud_options.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

void main() {
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
}
