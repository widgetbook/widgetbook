import 'dart:collection';

import 'bot.dart';
import 'util.dart';

class Commit {
  final String treeSha;
  final String author;
  final String committer;
  final String message;
  final String content;
  final List<String> parents;

  Commit._(this.treeSha, this.author, this.committer, this.message,
      this.content, List<String> parents)
      : parents = UnmodifiableListView<String>(parents) {
    requireArgumentValidSha1(treeSha, 'treeSha');
    for (final parent in parents) {
      requireArgumentValidSha1(parent, 'parents');
    }

    // null checks on many things
    // unique checks on parents
  }

  static Commit parse(String content) {
    final stringLineReader = StringLineReader(content);
    final tuple = _parse(stringLineReader, false);
    assert(tuple.item1 == null);
    return tuple.item2;
  }

  static Map<String, Commit> parseRawRevList(String content) {
    final slr = StringLineReader(content);

    final commits = <String, Commit>{};

    while (slr.position != null && slr.position! < content.length) {
      final tuple = _parse(slr, true);
      commits[tuple.item1!] = tuple.item2;
    }

    return commits;
  }

  static Tuple<String?, Commit> _parse(StringLineReader slr, bool isRevParse) {
    assert(slr.position != null);

    final headers = <String, List<String>>{};

    final startSpot = slr.position!;
    var lastLine = slr.readNextLine();

    while (lastLine != null && lastLine.isNotEmpty) {
      final allHeaderMatches = headerRegExp.allMatches(lastLine);
      if (allHeaderMatches.isNotEmpty) {
        final match = allHeaderMatches.single;
        assert(match.groupCount == 2);
        final header = match.group(1)!;
        final value = match.group(2)!;

        headers.putIfAbsent(header, () => <String>[]).add(value);
      }

      lastLine = slr.readNextLine()!;
    }

    assert(lastLine!.isEmpty);

    String message;

    if (isRevParse) {
      final msgLines = <String>[];
      lastLine = slr.readNextLine();

      const revParseMessagePrefix = '    ';
      while (lastLine != null && lastLine.startsWith(revParseMessagePrefix)) {
        msgLines.add(lastLine.substring(revParseMessagePrefix.length));
        lastLine = slr.readNextLine();
      }

      message = msgLines.join('\n');
    } else {
      message = slr.readToEnd()!;
      assert(message.endsWith('\n'));
      final originalMessageLength = message.length;
      message = message.trim();
      // message should be trimmed by git, so the only diff after trim
      // should be 1 character - the removed new line
      assert(message.length + 1 == originalMessageLength);
    }

    final treeSha = headers['tree']!.single;
    final author = headers['author']!.single;
    final committer = headers['committer']!.single;
    final commitSha =
        headers.containsKey('commit') ? headers['commit']!.single : null;

    final parents = headers['parent'] ?? [];

    final endSpot = slr.position;

    final content = slr.source.substring(startSpot, endSpot);

    return Tuple(commitSha,
        Commit._(treeSha, author, committer, message, content, parents));
  }
}
