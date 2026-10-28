import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/commands/cloud_options.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

void main() {
  late ArgParser parser;

  setUp(() {
    parser = ArgParser()..addApiUrlOption();
  });

  group('addApiUrlOption', () {
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
  });

  group('parseApiUrlOption', () {
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

    for (final url in [
      'api.widgetbook.io',
      'ftp://x',
      'https://',
      'https://host/?x',
    ]) {
      test('rejects $url as a usage error', () {
        expect(
          () => parseApiUrlOption(parser.parse(['--api-url', url])),
          throwsA(
            isA<CliException>()
                .having((e) => e.exitCode, 'exitCode', ExitCode.usage.code)
                .having(
                  (e) => e.message,
                  'message',
                  'The --api-url option must be an http or https URL, '
                      'got "$url".',
                ),
          ),
        );
      });
    }
  });
}
