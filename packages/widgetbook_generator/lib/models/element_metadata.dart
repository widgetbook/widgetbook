import 'package:path/path.dart' as path;

class ElementMetadata {
  ElementMetadata({
    required this.name,
    required this.importUri,
    required this.filePath,
  });

  /// The name of the element.
  final String name;

  /// The import uri of the file that contains the element.
  /// Examples:
  /// - `package:foo/src/widgets/bar.dart` (file is inside the `lib` directory)
  /// - `asset:foo/src/widgets/bar.dart` (file is outside the `lib` directory)
  final String importUri;

  /// The path to the file that contains the element.
  final String filePath;

  /// Converts the import uri to a relative path.
  ///
  /// If the file is located outside the lib directory, then the uri will be an
  /// "asset:" uri. In this case, we need to convert it to a relative path,
  /// relative to the [from] directory.
  String importUriRelative(String from) {
    final uri = Uri.parse(importUri);

    if (uri.scheme != 'asset') return importUri;

    return path.relative(
      uri.path,
      from: from,
    );
  }
}
