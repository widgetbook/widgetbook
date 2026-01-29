import 'docs.dart';

/// Extension methods for manipulating lists of [DocBlock]s.
/// Provides utilities to insert or replace [DocBlock]s.
extension DocsBlockListExtension on List<DocBlock> {
  /// Inserts [block] after the first occurrence of a block of type [T].
  /// Returns the modified list for chaining.
  List<DocBlock> insertAfter<T extends DocBlock>(DocBlock block) {
    final index = indexWhere((b) => b is T);
    if (index == -1) {
      add(block);
    } else {
      insert(index + 1, block);
    }
    return this;
  }

  /// Inserts [block] before the first occurrence of a block of type [T].
  /// Returns the modified list for chaining.
  List<DocBlock> insertBefore<T extends DocBlock>(DocBlock block) {
    final index = indexWhere((b) => b is T);
    if (index == -1) {
      add(block);
    } else {
      insert(index, block);
    }
    return this;
  }

  /// Replaces the first occurrence of a block of type [T] with [block].
  /// Returns the modified list for chaining.
  List<DocBlock> replaceFirst<T extends DocBlock>(DocBlock block) {
    final index = indexWhere((b) => b is T);
    if (index != -1) {
      this[index] = block;
    }
    return this;
  }
}
