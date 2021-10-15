abstract class WidgetbookData {
  final String name;
  final String importStatement;
  final List<String> dependencies;
  WidgetbookData({
    required this.name,
    required this.importStatement,
    required this.dependencies,
  });

  Map<String, dynamic> toMap();
}
