import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

void main() {
  group('$CommentStore', () {
    late Directory root;
    late CommentStore store;

    setUp(() {
      root = Directory.systemTemp.createTempSync('comments');
      store = CommentStore(root: root.path);
    });

    tearDown(() async {
      await store.close();
      root.deleteSync(recursive: true);
    });

    Comment createDraft({String storyPath = 'widgets/Card/Default'}) {
      return store.create(storyPath: storyPath, text: 'Use a larger title');
    }

    test('stores comments in a directory that git ignores', () {
      createDraft();

      final directory = Directory(p.join(root.path, '.widgetbook', 'comments'));
      expect(
        File(p.join(directory.path, '.gitignore')).readAsStringSync(),
        '*\n',
      );
      expect(store.list(), hasLength(1));
    });

    test('keeps comments across store instances', () {
      final draft = createDraft();

      final reopened = CommentStore(root: root.path);
      expect(reopened.get(draft.id).messages.single.text, 'Use a larger title');
    });

    test('writes the screenshot next to the comment', () {
      final comment = store.create(
        storyPath: 'widgets/Card/Default',
        text: 'Too much padding',
        screenshotPng: [1, 2, 3],
      );

      expect(store.screenshotFile(comment).readAsBytesSync(), [1, 2, 3]);

      store.delete(comment.id);
      expect(store.screenshotFile(comment).existsSync(), isFalse);
    });

    test('makes file locations below the root relative', () {
      final file = p.join(root.path, 'lib', 'card.dart');
      final comment = store.create(
        storyPath: 'widgets/Card/Default',
        text: 'Too much padding',
        anchor: {
          'location': {'file': Uri.file(file).toString(), 'line': 4},
          'chain': [
            {'file': '/elsewhere/lib/app.dart', 'line': 1},
          ],
        },
      );

      expect(comment.anchor['location'], {'file': 'lib/card.dart', 'line': 4});
      expect(comment.anchor['chain'], [
        {'file': '/elsewhere/lib/app.dart', 'line': 1},
      ]);
    });

    test('submits drafts as one review', () async {
      final first = createDraft();
      final second = createDraft(storyPath: 'widgets/Card/Dense');

      final submissions = store.submissions.first;
      final submitted = store.submit();

      expect(submitted.map((comment) => comment.id), [first.id, second.id]);
      expect(await submissions, hasLength(2));
      expect(
        store.list().map((comment) => comment.status),
        everyElement(CommentStatus.open),
      );
      expect(store.submit(), isEmpty);
    });

    test('limits a review to a story', () {
      createDraft();
      createDraft(storyPath: 'widgets/Card/Dense');

      expect(store.submit(storyPath: 'widgets/Card/Dense'), hasLength(1));
      expect(
        store.list(statuses: {CommentStatus.draft}).single.storyPath,
        'widgets/Card/Default',
      );
    });

    test('lets the agent mark a comment as done but not resolve it', () {
      final comment = createDraft();
      store.submit();

      store.setStatus(
        comment.id,
        CommentAuthor.agent,
        CommentStatus.inProgress,
      );
      store.setStatus(comment.id, CommentAuthor.agent, CommentStatus.done);

      expect(
        () => store.setStatus(
          comment.id,
          CommentAuthor.agent,
          CommentStatus.resolved,
        ),
        throwsA(isA<CommentTransitionException>()),
      );

      store.setStatus(comment.id, CommentAuthor.user, CommentStatus.resolved);
      expect(store.get(comment.id).status, CommentStatus.resolved);
    });

    test('does not let the agent pick up drafts', () {
      final comment = createDraft();

      expect(
        () => store.setStatus(
          comment.id,
          CommentAuthor.agent,
          CommentStatus.inProgress,
        ),
        throwsA(isA<CommentTransitionException>()),
      );
    });

    test('reopens a done comment when the user replies', () {
      final comment = createDraft();
      store
        ..submit()
        ..setStatus(comment.id, CommentAuthor.agent, CommentStatus.done)
        ..reply(comment.id, CommentAuthor.agent, 'Increased the title size');

      final reopened = store.reply(comment.id, CommentAuthor.user, 'Larger');

      expect(reopened.status, CommentStatus.open);
      expect(reopened.messages.map((message) => message.author), [
        CommentAuthor.user,
        CommentAuthor.agent,
        CommentAuthor.user,
      ]);
    });

    test('rejects ids that are not comment ids', () {
      expect(
        () => store.get('../secrets'),
        throwsA(isA<CommentNotFoundException>()),
      );
    });
  });
}
