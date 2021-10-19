abstract class WidgetbookData {
  WidgetbookData({
    required this.name,
    required this.importStatement,
    required this.dependencies,
  });

  final String name;
  final String importStatement;
  final List<String> dependencies;

  Map<String, dynamic> toMap();
}
