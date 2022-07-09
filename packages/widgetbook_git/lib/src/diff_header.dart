class DiffHeader {
  final String? baseFile;
  final String? refFile;

  DiffHeader({
    required this.baseFile,
    required this.refFile,
  });

  bool get isNew => baseFile == null && refFile != null;
  bool get isRemoved => baseFile != null && refFile == null;
  bool get isRenamed =>
      baseFile != refFile && baseFile != null && refFile != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiffHeader &&
          runtimeType == other.runtimeType &&
          baseFile == other.baseFile &&
          refFile == other.refFile;

  @override
  int get hashCode => Object.hash(
        baseFile,
        refFile,
      );

  @override
  String toString() => '$DiffHeader(baseFile: $baseFile, refFile: $refFile)';
}
