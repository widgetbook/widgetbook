class HunkRange {
  const HunkRange({
    required this.startLine,
    required this.numberOfLines,
  });

  final int startLine;
  final int numberOfLines;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HunkRange &&
          runtimeType == other.runtimeType &&
          startLine == other.startLine &&
          numberOfLines == other.numberOfLines;

  @override
  int get hashCode => Object.hash(
        startLine,
        numberOfLines,
      );

  @override
  String toString() =>
      '$HunkRange(startLine: $startLine, numberOfLines: $numberOfLines)';
}

class Hunk {
  const Hunk({
    required this.baseRange,
    required this.refRange,
    required this.content,
  });

  final HunkRange baseRange;
  final HunkRange refRange;
  final String content;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hunk &&
          runtimeType == other.runtimeType &&
          baseRange == other.baseRange &&
          refRange == other.refRange &&
          content == other.content;

  @override
  int get hashCode => Object.hash(
        baseRange,
        refRange,
        content,
      );

  @override
  String toString() => '$Hunk(baseRange: $baseRange, refRange: $refRange, '
      'content: $content)';
}
