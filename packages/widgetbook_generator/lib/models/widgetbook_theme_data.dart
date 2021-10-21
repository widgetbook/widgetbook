import 'package:analyzer/dart/element/element.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

/// Contains the data of a Theme
class WidgetbookThemeData extends WidgetbookData {
  /// Creates a new instance of [WidgetbookThemeData]
  ///
  /// [name] is defined as the identifier of the annotated element
  /// [importStatement] is the statement required to include the annotated
  /// element in the Widgetbook
  /// [dependencies] are the import statements defined in the file in which the
  /// annotation is used
  /// [isDarkTheme] specified whether the theme is dark or light
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

  /// Obtains a [WidgetbookThemeData] object from classes provided by the
  /// ThemeResolver
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

  /// transforms the serializable map into a [WidgetbookThemeData] object.
  factory WidgetbookThemeData.fromMap(Map<String, dynamic> map) {
    return WidgetbookThemeData(
      name: map['name'] as String,
      importStatement: map['importStatement'] as String,
      dependencies: List<String>.from(map['dependencies'] as Iterable),
      isDarkTheme: map['isDarkTheme'] as bool,
    );
  }

  /// indicates whether the Theme is dark or light
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
