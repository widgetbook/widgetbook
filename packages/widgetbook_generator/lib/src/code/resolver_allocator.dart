import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as path;

/// Converts 'asset:' import URIs to relative paths, relative to [baseDir],
/// then delegates all imports to [Allocator.simplePrefixing].
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
    return '_${_imports.putIfAbsent(url, () => url.split('/').last.replaceAll('.dart', ''))}.$symbol';
  }

  @override
  Iterable<Directive> get imports => _imports.keys.map(
        (u) => Directive.import(u, as: '_${_imports[u]}'),
      );
}
