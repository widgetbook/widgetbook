import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as path;

/// An [Allocator] that prefixes imports with a namespace
/// derived from basename of the import URL.
class NamedAllocator implements Allocator {
  static const _doNotPrefix = ['dart:core'];

  final _imports = <String, String>{};

  @override
  String allocate(Reference reference) {
    final symbol = reference.symbol;
    final url = reference.url;
    if (url == null || _doNotPrefix.contains(url)) {
      return symbol!;
    }

    final decodedUrl = _decodeUrl(url);
    final namespace = _imports.putIfAbsent(
      decodedUrl,
      () => _getUniqueNamespace(decodedUrl),
    );

    return '$namespace.$symbol';
  }

  String _getUniqueNamespace(String url) {
    // Convert the URL `package:foo/bar/qux.dart` to `foo/bar/qux` by removing
    // the 'package:' prefix and '.dart' suffix.
    final plainUrl = url.replaceFirst('package:', '').replaceAll('.dart', '');

    // If the URL is a barrel export, use the package name as the namespace.
    if (path.split(plainUrl) case [
      final String package,
      final String file,
    ] when package == file) {
      return '_$package';
    }

    // Replace all non-alphanumeric characters in the URL with underscores
    // to ensure a valid namespace.
    final sanitizedUrl = plainUrl.replaceAll(RegExp('[^a-zA-Z0-9]'), '_');

    // Generate a namespace by prefixing the sanitized URL with an underscore.
    final namespace = '_$sanitizedUrl';

    return namespace;
  }

  /// Decodes URL-encoded characters in the given [url].
  /// Mainly to remove the square brackets when used in folder names
  /// for the "categories" feature.
  String _decodeUrl(String url) {
    return Uri.decodeFull(url);
  }

  @override
  Iterable<Directive> get imports => [
    for (final MapEntry(key: url, value: namespace) in _imports.entries)
      Directive.import(
        url,
        as: namespace,
      ),
  ];
}
