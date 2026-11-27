@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/core/cli_exception.dart';
import 'package:widgetbook_cli/src/test/stories_resolver.dart';
import 'package:widgetbook_cli/src/test/test_exit_codes.dart';

void main() {
  group('$StoriesResolver', () {
    late Directory root;
    late StoriesResolver resolver;

    void write(String path, String content) {
      File(p.join(root.path, path))
        ..createSync(recursive: true)
        ..writeAsStringSync(content);
    }

    Matcher throwsCliException(int exitCode, String message) {
      return throwsA(
        isA<CliException>()
            .having((e) => e.exitCode, 'exitCode', exitCode)
            .having((e) => e.message, 'message', contains(message)),
      );
    }

    setUp(() {
      root = Directory.systemTemp.createTempSync('wb_stories_resolver');
      resolver = StoriesResolver(root.path);

      write('lib/counter.stories.dart', 'const meta = Meta(Counter.new);');
      write('lib/counter.stories.g.dart', 'part of "counter.stories.dart";');
      write(
        'lib/buttons/button.stories.dart',
        'const meta = Meta(Button.new);',
      );
      write(
        'lib/buttons/icon_button.stories.dart',
        'const meta = Meta(IconButton.icon);',
      );
      write('lib/buttons/button.dart', 'class Button {}');
      write('lib/[shared]/avatar.stories.dart', '''
final component = ComponentMeta(name: 'Profile Picture', path: '[x]');
const meta = Meta(Avatar.new);
''');
    });

    tearDown(() => root.deleteSync(recursive: true));

    test('resolves a file to its widget', () {
      expect(
        resolver.resolve(['lib/counter.stories.dart']),
        {
          'lib/counter.stories.dart': {'Counter'},
        },
      );
    });

    test('resolves a folder to every stories file below it', () {
      expect(
        resolver.resolve(['lib/buttons/']),
        {
          'lib/buttons/button.stories.dart': {'Button'},
          'lib/buttons/icon_button.stories.dart': {'IconButton'},
        },
      );
    });

    test('resolves a glob to the stories files it matches', () {
      expect(
        resolver.resolve(['lib/**/*button*']),
        {
          'lib/buttons/button.stories.dart': {'Button'},
          'lib/buttons/icon_button.stories.dart': {'IconButton'},
        },
      );
    });

    test('reads an existing path with glob characters literally', () {
      expect(
        resolver.resolve(['lib/[shared]/avatar.stories.dart']),
        {
          'lib/[shared]/avatar.stories.dart': {'Profile Picture'},
        },
      );
    });

    test('prefers the ComponentMeta name over the widget', () {
      expect(
        resolver.componentNames('lib/[shared]/avatar.stories.dart'),
        {'Profile Picture'},
      );
    });

    test('falls back to the widget when ComponentMeta sets no name', () {
      write('lib/card.stories.dart', '''
final component = ComponentMeta(path: 'cards');
const meta = Meta(CustomCard.new);
''');

      expect(resolver.componentNames('lib/card.stories.dart'), {'CustomCard'});
    });

    test('rejects a ComponentMeta name that is not a literal', () {
      write('lib/card.stories.dart', '''
final component = ComponentMeta(name: cardName);
const meta = Meta(CustomCard.new);
''');

      expect(
        () => resolver.componentNames('lib/card.stories.dart'),
        throwsCliException(TestExitCodes.noComponent, 'not a string literal'),
      );
    });

    test('merges paths that select the same file', () {
      expect(
        resolver.resolve([
          'lib/counter.stories.dart',
          'lib/*.stories.dart',
        ]),
        {
          'lib/counter.stories.dart': {'Counter'},
        },
      );
    });

    test('throws when a path matches no file', () {
      expect(
        () => resolver.resolve(['lib/missing.stories.dart']),
        throwsCliException(
          TestExitCodes.pathNotFound,
          'lib/missing.stories.dart not found',
        ),
      );
      expect(
        () => resolver.resolve(['lib/**/missing*.stories.dart']),
        throwsCliException(TestExitCodes.pathNotFound, 'not found'),
      );
    });

    test('throws when a folder has no stories file', () {
      Directory(p.join(root.path, 'lib/empty')).createSync();

      expect(
        () => resolver.resolve(['lib/empty']),
        throwsCliException(TestExitCodes.pathNotFound, 'lib/empty not found'),
      );
    });

    test('throws when a file declares no component', () {
      expect(
        () => resolver.resolve(['lib/buttons/button.dart']),
        throwsCliException(
          TestExitCodes.noComponent,
          'lib/buttons/button.dart declares no Widgetbook component',
        ),
      );
    });
  });
}
