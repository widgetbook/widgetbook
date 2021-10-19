import 'package:analyzer/dart/element/element.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

class WidgetbookThemeData extends WidgetbookData {
  WidgetbookThemeData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
    required this.isDarkTheme,
  }) : super(
          name: name,
          importStatement: importStatement,
          dependencies: dependencies,
        );

  factory WidgetbookThemeData.fromResolver(
    Element element,
    bool isDarkTheme,
  ) {
    return WidgetbookThemeData(
      name: element.name!,
      importStatement: element.importStatement,
      dependencies: element.dependencies,
      isDarkTheme: isDarkTheme,
    );
  }

  factory WidgetbookThemeData.fromMap(Map<String, dynamic> map) {
    return WidgetbookThemeData(
      name: map['name'] as String,
      importStatement: map['importStatement'] as String,
      dependencies: List<String>.from(map['dependencies'] as Iterable),
      isDarkTheme: map['isDarkTheme'] as bool,
    );
  }

  final bool isDarkTheme;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'importStatement': importStatement,
      'dependencies': dependencies,
      'isDarkTheme': isDarkTheme,
    };
  }
}
