import 'package:change_case/change_case.dart';
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
  final _namespaces = <String>{};

  @override
  String allocate(Reference reference) {
    final symbol = reference.symbol;
    final url = reference.url;
    if (url == null || _doNotPrefix.contains(url)) {
      return symbol!;
    }

    final namespace = _imports.putIfAbsent(url, () => _getNamespace(url));

    return '${namespace}.$symbol';
  }

  String _getNamespace(String url) {
    final basename = path.basenameWithoutExtension(url);

    final segments = path.split(url).reversed.skip(1);

    int? index;
    String indexedNamespace() {
      final dirs = segments.take(index ?? 0).toList().reversed;
      return switch (index) {
        null => '_$basename',
        int() => '_${dirs.join('_')}_${basename}',
      }
          .toNoCase()
          .toSnakeCase();
    }

    while (_namespaces.contains(indexedNamespace())) {
      index ??= 0;
      index++;

      // If we've tried all segments, throw an error.
      //
      // This is a sanity check to prevent infinite loops.
      if (index > segments.length) {
        throw Exception('Failed to find a unique namespace for $url');
      }
    }

    final namespace = indexedNamespace();

    _namespaces.add(namespace);

    return namespace;
  }

  @override
  Iterable<Directive> get imports => _imports.keys.map(
        (u) => Directive.import(u, as: _imports[u]),
      );
}
