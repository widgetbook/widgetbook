/// [WidgetbookData] contains information about the annotated element.
abstract class WidgetbookData {
  WidgetbookData({
    required this.name,
    required this.importStatement,
    required this.dependencies,
  });

  /// The name of the annotated element
  final String name;

  /// The import statement necessary to reference this type or function in the
  /// final output file
  final String importStatement;

  /// The import statements defined by the file in which the annotation is used.
  final List<String> dependencies;

  /// Maps this object into a serializable format
  Map<String, dynamic> toMap();
}
