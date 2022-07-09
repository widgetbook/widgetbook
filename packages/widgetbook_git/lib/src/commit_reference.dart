import 'dart:convert';

import 'branch_reference.dart';
import 'util.dart';

/// Represents the output from `git show-ref`
class CommitReference {
  static final RegExp _lsRemoteRegExp = RegExp('^($shaRegexPattern) (.+)\$');

  final String sha;
  final String reference;

  CommitReference(this.sha, this.reference) {
    requireArgumentValidSha1(sha, 'sha');

    // TODO: probably a better way to verify...but this is fine for now
    assert(reference.startsWith(r'refs/') || reference == 'HEAD');
  }

  static List<CommitReference> fromShowRefOutput(String input) {
    final lines = const LineSplitter().convert(input);

    return lines.sublist(0, lines.length).map((line) {
      final match = _lsRemoteRegExp.allMatches(line).single;
      assert(match.groupCount == 2);

      return CommitReference(match[1]!, match[2]!);
    }).toList();
  }

  BranchReference toBranchReference() => BranchReference(sha, reference);

  @override
  String toString() => 'GitReference: $reference  $sha';
}
