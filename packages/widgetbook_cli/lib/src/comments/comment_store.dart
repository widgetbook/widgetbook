import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;

import 'comment.dart';

class CommentNotFoundException implements Exception {
  CommentNotFoundException(this.id);

  final String id;

  @override
  String toString() => 'Comment "$id" does not exist.';
}

class CommentTransitionException implements Exception {
  CommentTransitionException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Stores comments as one JSON file per thread in
/// `<root>/.widgetbook/comments`, next to their screenshots.
///
/// The directory ignores itself in git, so comments stay local.
class CommentStore {
  CommentStore({
    required this.root,
    DateTime Function()? now,
    Random? random,
  }) : _now = now ?? DateTime.now,
       _random = random ?? Random.secure();

  final String root;
  final DateTime Function() _now;
  final Random _random;

  final _submissions = StreamController<List<Comment>>.broadcast();

  /// Emits the comments of every review the user submits.
  Stream<List<Comment>> get submissions => _submissions.stream;

  Directory get directory {
    return Directory(p.join(root, '.widgetbook', 'comments'));
  }

  List<Comment> list({
    String? storyPath,
    Set<CommentStatus>? statuses,
  }) {
    if (!directory.existsSync()) return [];

    final comments =
        directory
            .listSync()
            .whereType<File>()
            .where((file) => p.extension(file.path) == '.json')
            .map(_read)
            .whereType<Comment>()
            .where(
              (comment) =>
                  (storyPath == null || comment.storyPath == storyPath) &&
                  (statuses == null || statuses.contains(comment.status)),
            )
            .toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return comments;
  }

  Comment get(String id) {
    final comment = _read(_jsonFile(id));
    if (comment == null) throw CommentNotFoundException(id);
    return comment;
  }

  File screenshotFile(Comment comment) {
    return File(p.join(directory.path, comment.screenshot));
  }

  Comment create({
    required String storyPath,
    required String text,
    String? storyUrl,
    Map<String, dynamic> anchor = const {},
    List<int>? screenshotPng,
  }) {
    _ensureDirectory();

    final id = _newId();
    final now = _now();
    final screenshot = screenshotPng == null ? null : '$id.png';

    if (screenshot != null) {
      File(p.join(directory.path, screenshot)).writeAsBytesSync(screenshotPng!);
    }

    final comment = Comment(
      id: id,
      storyPath: storyPath,
      storyUrl: storyUrl,
      status: CommentStatus.draft,
      anchor: _relativizeFiles(anchor) as Map<String, dynamic>,
      messages: [
        CommentMessage(
          author: CommentAuthor.user,
          text: text,
          createdAt: now,
        ),
      ],
      createdAt: now,
      updatedAt: now,
      screenshot: screenshot,
    );

    _write(comment);
    return comment;
  }

  /// Adds a message to the thread. A user reply on a comment the agent
  /// marked as [CommentStatus.done] (or one that was resolved) reopens it.
  Comment reply(String id, CommentAuthor author, String text) {
    final comment = get(id);

    comment.messages.add(
      CommentMessage(author: author, text: text, createdAt: _now()),
    );

    if (author == CommentAuthor.user &&
        (comment.status == CommentStatus.done ||
            comment.status == CommentStatus.resolved)) {
      comment.status = CommentStatus.open;
    }

    return _touch(comment);
  }

  Comment setStatus(String id, CommentAuthor author, CommentStatus status) {
    final comment = get(id);
    final allowed = switch (author) {
      CommentAuthor.agent => _agentTransitions,
      CommentAuthor.user => _userTransitions,
    };

    if (!(allowed[comment.status]?.contains(status) ?? false)) {
      throw CommentTransitionException(
        'The ${author.name} cannot move a comment from '
        '"${comment.status.name}" to "${status.name}".',
      );
    }

    comment.status = status;
    return _touch(comment);
  }

  void delete(String id) {
    final comment = get(id);
    _jsonFile(id).deleteSync();
    if (comment.screenshot != null) {
      final screenshot = screenshotFile(comment);
      if (screenshot.existsSync()) screenshot.deleteSync();
    }
  }

  /// Submits all drafts, optionally limited to [storyPath], as one review.
  List<Comment> submit({String? storyPath}) {
    final drafts = list(
      storyPath: storyPath,
      statuses: {CommentStatus.draft},
    );

    for (final draft in drafts) {
      draft.status = CommentStatus.open;
      _touch(draft);
    }

    if (drafts.isNotEmpty) _submissions.add(drafts);
    return drafts;
  }

  Future<void> close() => _submissions.close();

  static const _agentTransitions = {
    CommentStatus.open: {CommentStatus.inProgress, CommentStatus.done},
    CommentStatus.inProgress: {CommentStatus.done},
  };

  static const _userTransitions = {
    CommentStatus.inProgress: {CommentStatus.open, CommentStatus.resolved},
    CommentStatus.open: {CommentStatus.resolved},
    CommentStatus.done: {CommentStatus.open, CommentStatus.resolved},
    CommentStatus.resolved: {CommentStatus.open},
  };

  Comment _touch(Comment comment) {
    comment.updatedAt = _now();
    _write(comment);
    return comment;
  }

  File _jsonFile(String id) {
    if (!RegExp(r'^[a-z0-9-]+$').hasMatch(id)) {
      throw CommentNotFoundException(id);
    }

    return File(p.join(directory.path, '$id.json'));
  }

  Comment? _read(File file) {
    if (!file.existsSync()) return null;

    try {
      final json = jsonDecode(file.readAsStringSync());
      return Comment.fromJson((json as Map).cast<String, dynamic>());
    } on FormatException {
      return null;
    }
  }

  void _write(Comment comment) {
    _ensureDirectory();

    final file = _jsonFile(comment.id);
    final temp = File('${file.path}.tmp');
    temp.writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(comment.toJson()),
    );
    temp.renameSync(file.path);
  }

  void _ensureDirectory() {
    if (directory.existsSync()) return;

    directory.createSync(recursive: true);
    File(p.join(directory.path, '.gitignore')).writeAsStringSync('*\n');
  }

  String _newId() {
    final time = _now().millisecondsSinceEpoch.toRadixString(36);
    final suffix = _random.nextInt(1 << 20).toRadixString(36).padLeft(4, '0');
    return '$time-$suffix';
  }

  /// Rewrites `file://` URIs below [root] in the UI's anchor to paths
  /// relative to [root], so that agents can open them directly.
  Object? _relativizeFiles(Object? value) {
    return switch (value) {
      Map() => {
        for (final entry in value.entries)
          entry.key as String: entry.key == 'file' && entry.value is String
              ? _relativePath(entry.value as String)
              : _relativizeFiles(entry.value),
      },
      List() => value.map(_relativizeFiles).toList(),
      _ => value,
    };
  }

  String _relativePath(String file) {
    final path = file.startsWith('file://')
        ? Uri.parse(file).toFilePath()
        : file;
    return p.isWithin(root, path) ? p.relative(path, from: root) : path;
  }
}
