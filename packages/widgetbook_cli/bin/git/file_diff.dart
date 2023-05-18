import 'package:collection/collection.dart';

import 'hunk.dart';
import 'modification.dart';

class FileDiff {
  FileDiff({
    required this.hunks,
    this.basePath,
    this.refPath,
  });

  final String? basePath;
  final String? refPath;
  final List<Hunk> hunks;

  bool get isNew => basePath == null && refPath != null;
  bool get isRemoved => basePath != null && refPath == null;
  bool get isRenamed =>
      basePath != refPath && basePath != null && refPath != null;

  Modification get modification {
    if (isRemoved) {
      return Modification.removed;
    }

    if (isNew) {
      return Modification.added;
    }

    return Modification.changed;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileDiff &&
          runtimeType == other.runtimeType &&
          basePath == other.basePath &&
          refPath == other.refPath &&
          const DeepCollectionEquality().equals(
            hunks,
            other.hunks,
          );

  @override
  int get hashCode => Object.hash(
        basePath,
        refPath,
        const DeepCollectionEquality().hash(hunks),
      );

  @override
  String toString() => '$FileDiff(basePath: $basePath, refPath: $refPath, '
      'hunks: $hunks)';
}
