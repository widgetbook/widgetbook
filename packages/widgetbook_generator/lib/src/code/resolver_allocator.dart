import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as path;

/// Converts 'asset:' import URIs to relative paths, relative to [baseDir],
/// then delegates all imports to [_NamedAllocator].
///
/// [_NamedAllocator] prefixes imports with a namespace derived from basename
/// of the import URL.
///
/// The 'asset:' URIs happen when a file is located outside the
/// `lib` directory, for example in the `test` directory.
class ResolverAllocator implements Allocator {
  ResolverAllocator(this.baseDir);

  final String baseDir;
  final _allocator = _NamedAllocator();

  @override
  String allocate(Reference reference) {
    return _allocator.allocate(reference);
  }

  @override
  Iterable<Directive> get imports => _allocator.imports.map(
    (directive) => Directive.import(
      convertToRelative(directive.url, baseDir),
      as: directive.as,
    ),
  );

  String convertToRelative(String url, String from) {
    final uri = Uri.parse(url);
    final relativeUrl = path.relative(
      uri.path,
      from: from,
    );

    return uri.scheme == 'asset' ? relativeUrl : url;
  }
}

class _NamedAllocator implements Allocator {
  static const _doNotPrefix = ['dart:core'];

  final _imports = <String, String>{};

  @override
  String allocate(Reference reference) {
    final symbol = reference.symbol;
    final url = reference.url;
    if (url == null || _doNotPrefix.contains(url)) {
      return symbol!;
    }

    final namespace = _imports.putIfAbsent(url, () => _getUniqueNamespace(url));

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

  @override
  Iterable<Directive> get imports => [
    for (final MapEntry(key: url, value: namespace) in _imports.entries)
      Directive.import(
        url,
        as: namespace,
      ),
  ];
}
