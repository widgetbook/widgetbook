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

/// Thrown when a comment is pinned to code outside of the project, e.g.
/// when the Widgetbook of another project reaches this server's port.
class CommentOutsideProjectException implements Exception {
  CommentOutsideProjectException(this.location, this.root);

  final String location;
  final String root;

  @override
  String toString() =>
      'The commented widget ($location) is not part of $root. '
      'Start `widgetbook mcp` in the project of this Widgetbook.';
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
    _checkInProject(anchor['location']);
    _ensureDirectory();

    final id = _newId();
    final now = _now();
    final screenshot = screenshotPng == null ? null : '$id.png';

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

    if (screenshot != null) {
      File(p.join(directory.path, screenshot)).writeAsBytesSync(screenshotPng!);
    }
    _write(comment);
    return comment;
  }

  /// Rejects anchors whose widget is created by code outside of [root].
  /// Only desktop file locations and web app locations are checked, as
  /// `package:` locations may point to other packages of a monorepo.
  void _checkInProject(Object? location) {
    if (location is! Map) return;

    final uri = location['uri'] ?? location['file'];
    if (uri is! String) return;

    const appScheme = 'org-dartlang-app:///';
    final inProject = switch (uri) {
      _ when uri.startsWith('file:') => _safely(
        () => p.isWithin(root, Uri.parse(uri).toFilePath()),
      ),
      _ when uri.startsWith(appScheme) => _safely(
        () => _findAppFile(uri.substring(appScheme.length)) != null,
      ),
      _ => true,
    };

    if (inProject == false) {
      throw CommentOutsideProjectException(
        location['file'] as String? ?? uri,
        root,
      );
    }
  }

  static T? _safely<T>(T Function() run) {
    try {
      return run();
    } on Exception {
      return null;
    } on ArgumentError {
      return null;
    } on UnsupportedError {
      return null;
    }
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
    _deleteIfExists(_jsonFile(id));
    if (comment.screenshot != null) _deleteIfExists(screenshotFile(comment));
  }

  static void _deleteIfExists(File file) {
    try {
      file.deleteSync();
    } on PathNotFoundException {
      return;
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

  /// Reads a comment, skipping files that are missing, e.g. deleted while
  /// listing, or that are not valid comments.
  Comment? _read(File file) {
    try {
      final json = jsonDecode(file.readAsStringSync());
      return Comment.fromJson((json as Map).cast<String, dynamic>());
    } on FileSystemException {
      return null;
    } on FormatException {
      return null;
    } on TypeError {
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

  /// Rewrites the `file` of each location in the UI's anchor to a path
  /// relative to [root] where possible, so that agents can open it directly.
  /// The location's `uri`, as reported at runtime, is kept for the UI.
  Object? _relativizeFiles(Object? value) {
    return switch (value) {
      Map() => _relativizeLocation({
        for (final entry in value.entries)
          entry.key as String: _relativizeFiles(entry.value),
      }),
      List() => value.map(_relativizeFiles).toList(),
      _ => value,
    };
  }

  Map<String, dynamic> _relativizeLocation(Map<String, dynamic> map) {
    final source = map['uri'] ?? map['file'];
    if (source is! String) return map;

    return {
      ...map,
      'file': _resolvedPaths[source] ??=
          _safely(() => _resolvePath(source)) ?? source,
    };
  }

  final _resolvedPaths = <String, String>{};

  String _resolvePath(String uri) {
    const appScheme = 'org-dartlang-app:///';

    if (uri.startsWith('file:')) return _relative(Uri.parse(uri).toFilePath());
    if (uri.startsWith(appScheme)) {
      return _findAppFile(uri.substring(appScheme.length)) ??
          uri.substring(appScheme.length);
    }
    if (uri.startsWith('package:')) return _findPackageFile(uri) ?? uri;
    return _relative(uri);
  }

  String _relative(String path) {
    return p.isWithin(root, path) ? p.relative(path, from: root) : path;
  }

  /// Finds the app that a web URI like `org-dartlang-app:///lib/card.dart`
  /// is relative to, which is [root] or one of its subdirectories.
  String? _findAppFile(String path) {
    for (final directory in _projectDirectories()) {
      final file = File(p.join(directory.path, path));
      if (file.existsSync()) return _relative(file.path);
    }
    return null;
  }

  /// Resolves a `package:` URI with the package configs in the project.
  String? _findPackageFile(String uri) {
    final parsed = Uri.parse(uri);
    if (parsed.pathSegments.isEmpty) return null;
    final name = parsed.pathSegments.first;

    for (final directory in _projectDirectories()) {
      final config = File(
        p.join(directory.path, '.dart_tool', 'package_config.json'),
      );
      if (!config.existsSync()) continue;

      final packages =
          (jsonDecode(config.readAsStringSync()) as Map)['packages'];
      final package = (packages as List).cast<Map<dynamic, dynamic>>().where(
        (package) => package['name'] == name,
      );
      if (package.isEmpty) continue;

      final rootUri = package.first['rootUri'] as String;
      final packageRoot = config.uri
          .resolve(rootUri.endsWith('/') ? rootUri : '$rootUri/')
          .resolve('${package.first['packageUri'] ?? 'lib/'}');
      final file = File.fromUri(
        packageRoot.resolve(parsed.pathSegments.skip(1).join('/')),
      );
      if (file.existsSync()) return _relative(file.path);
    }
    return null;
  }

  Iterable<Directory> _subdirectories(Directory directory) {
    try {
      return directory.listSync().whereType<Directory>();
    } on FileSystemException {
      return const [];
    }
  }

  Iterable<Directory> _projectDirectories({int depth = 4}) sync* {
    const skipped = {'build', 'node_modules', 'Pods'};
    var level = [Directory(root)];

    for (var i = 0; i <= depth && level.isNotEmpty; i++) {
      yield* level;
      level = [
        for (final directory in level)
          ..._subdirectories(directory).where((child) {
            final name = p.basename(child.path);
            return !name.startsWith('.') && !skipped.contains(name);
          }),
      ];
    }
  }
}
