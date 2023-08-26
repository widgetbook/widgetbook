import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as path;

/// Converts 'asset:' import URIs to relative paths, relative to [baseDir].
///
/// The 'asset:' URIs happen when a file is located outside the
/// `lib` directory, for example in the `test` directory.
class ResolverAllocator implements Allocator {
  ResolverAllocator(this.baseDir);

  final String baseDir;
  final _allocator = Allocator();

  @override
  String allocate(Reference reference) {
    return _allocator.allocate(reference);
  }

  @override
  Iterable<Directive> get imports => _allocator.imports.map(
        (directive) => Directive.import(
          convertToRelative(directive.url, baseDir),
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
