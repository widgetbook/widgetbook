import 'dart:convert';

import 'bot.dart';
import 'util.dart';

const _lsTreeLine =
// ignore: prefer_interpolation_to_compose_strings
    r'^([0-9]{6}) (blob|tree) (' + shaRegexPattern + ')\t(\\S.*\\S)\$';

class TreeEntry {
  static final _lsTreeRegEx = RegExp(_lsTreeLine);

  /// All numbers.
  ///
  /// See this this [post on stackoverflow](http://stackoverflow.com/questions/737673/how-to-read-the-mode-field-of-git-ls-trees-output)
  final String mode;

  // TODO: enum for type?
  final String type;
  final String sha;
  final String name;

  TreeEntry(this.mode, this.type, this.sha, this.name) {
    // TODO: enum or whitelist here
    requireArgumentContainsPattern(RegExp(r'^[0-9]{6}$'), mode, 'mode');

    // TODO: enum or whitelist here
    requireArgumentContainsPattern(RegExp(r'^[a-z]+$'), type, 'type');
    requireArgumentValidSha1(sha, 'sha');

    // TODO: how can we be more careful here? no paths? hmm...
    requireArgumentNotNullOrEmpty(name, 'name');
  }

  factory TreeEntry.fromLsTree(String value) {
    // TODO: should catch and re-throw a descriptive error
    final match = _lsTreeRegEx.allMatches(value).single;

    return TreeEntry(match[1]!, match[2]!, match[3]!, match[4]!);
  }

  @override
  String toString() => '$mode $type $sha\t$name';

  static List<TreeEntry> fromLsTreeOutput(String output) {
    final lines = const LineSplitter().convert(output);

    return lines
        .sublist(0, lines.length)
        .map((line) => TreeEntry.fromLsTree(line))
        .toList();
  }
}
