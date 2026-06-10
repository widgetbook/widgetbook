import '../docs/docs.dart';
import 'meta.dart';

/// Component-level metadata for a stories file.
///
/// Optional — declare at most one per stories file to customize the
/// component's [name], [path], or [docsBuilder]. The component widget is
/// derived from the file's [Meta] constructor tear-offs.
class ComponentMeta {
  const ComponentMeta({
    this.name,
    this.path,
    this.docsBuilder,
  });

  final String? name;
  final String? path;
  final DocsBuilderFunction? docsBuilder;
}
