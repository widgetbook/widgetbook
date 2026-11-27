import 'package:test/test.dart';
import 'package:widgetbook_cli/src/core/cli_exception.dart';
import 'package:widgetbook_cli/src/test/selection.dart';

void main() {
  group('$Selection', () {
    test('parses one to three levels', () {
      expect(Selection.parse('Counter').levels, ['Counter']);
      expect(Selection.parse('Counter/Default').levels, ['Counter', 'Default']);
      expect(
        Selection.parse('Counter/Default/Loading • Dark').levels,
        ['Counter', 'Default', 'Loading • Dark'],
      );
    });

    test('rejects empty levels and more than three levels', () {
      for (final filter in ['', 'Counter/', '/Default', 'A/B/C/D', 'A/ /C']) {
        expect(
          () => Selection.parse(filter),
          throwsA(isA<CliException>()),
          reason: filter,
        );
      }
    });

    test('matches whole names only', () {
      final regex = RegExp(buildNameRegex([Selection.parse('Button')])!);

      expect(regex.hasMatch('Button Default Primary'), isTrue);
      expect(regex.hasMatch('IconButton Default Primary'), isFalse);
      expect(regex.hasMatch('ButtonGroup Default Primary'), isFalse);
    });

    test('matches a story of a component', () {
      final regex = RegExp(
        buildNameRegex([Selection.parse('Counter/Default')])!,
      );

      expect(regex.hasMatch('Counter Default 10++'), isTrue);
      expect(regex.hasMatch('Counter DefaultLarge 10++'), isFalse);
      expect(regex.hasMatch('Counter Other 10++'), isFalse);
    });

    test('matches a whole scenario name', () {
      final regex = RegExp(
        buildNameRegex([Selection.parse('Counter/Default/Loading • Dark')])!,
      );

      expect(regex.hasMatch('Counter Default Loading • Dark'), isTrue);
      expect(regex.hasMatch('Counter Default Loading • Dark Mode'), isFalse);
      expect(regex.hasMatch('Counter Default Loading'), isFalse);
    });

    test('escapes regex characters in names', () {
      final regex = RegExp(
        buildNameRegex([Selection.parse('Counter/Default/10++ (x)')])!,
      );

      expect(regex.hasMatch('Counter Default 10++ (x)'), isTrue);
      expect(regex.hasMatch('Counter Default 100 x'), isFalse);
    });

    test('matches any name at a wildcard level', () {
      final regex = RegExp(buildNameRegex([Selection.parse('*/Default')])!);

      expect(regex.hasMatch('Counter Default 10++'), isTrue);
      expect(regex.hasMatch('Avatar Default Small'), isTrue);
      expect(regex.hasMatch('Avatar Other Small'), isFalse);
    });
  });

  group('buildNameRegex', () {
    test('returns null when nothing is selected', () {
      expect(buildNameRegex([]), isNull);
    });

    test('anchors a single selection', () {
      expect(buildNameRegex([Selection.parse('Counter')]), '^Counter ');
      expect(
        buildNameRegex([Selection.parse('Counter/Default')]),
        '^Counter Default ',
      );
    });

    test('combines selections into one alternation', () {
      final pattern = buildNameRegex([
        Selection.parse('Counter'),
        Selection.parse('Avatar/Default'),
      ]);

      expect(pattern, '^(?:Counter |Avatar Default )');

      final regex = RegExp(pattern!);
      expect(regex.hasMatch('Counter Default 10++'), isTrue);
      expect(regex.hasMatch('Avatar Default Small'), isTrue);
      expect(regex.hasMatch('Avatar Other Small'), isFalse);
    });

    test('drops duplicate selections', () {
      expect(
        buildNameRegex([
          Selection.parse('Counter'),
          Selection.component('Counter'),
        ]),
        '^Counter ',
      );
    });
  });
}
