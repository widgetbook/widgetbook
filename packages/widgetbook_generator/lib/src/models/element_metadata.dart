class ElementMetadata {
  const ElementMetadata({
    required this.name,
    required this.importUri,
    required this.filePath,
  });

  /// The name of the element.
  final String name;

  /// The import uri of the file that contains the element.
  ///
  /// Examples:
  /// - `package:foo/src/widgets/bar.dart` (file is inside the `lib` directory)
  /// - `asset:foo/src/widgets/bar.dart` (file is outside the `lib` directory)
  final String importUri;

  /// The path to the file that contains the element.
  final String filePath;

  String get package => Uri.parse(importUri).pathSegments.first;
}
