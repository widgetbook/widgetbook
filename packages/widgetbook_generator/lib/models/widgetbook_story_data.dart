import 'package:analyzer/dart/element/element.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

/// Contains the data of a Story
class WidgetbookStoryData extends WidgetbookData {
  /// Creates a new instance of [WidgetbookStoryData]
  ///
  /// [name] is defined as the identifier of the annotated element
  /// [importStatement] is the statement required to include the annotated
  /// element in the Widgetbook
  /// [dependencies] are the import statements defined in the file in which the
  /// annotation is used
  /// [storyName] is the name of the Story provided as a parameter of the
  /// WidgetbookStory annotation
  /// [widgetName] is the String version of the Widget type
  WidgetbookStoryData({
    required String name,
    required String importStatement,
    required this.typeDefinition,
    required List<String> dependencies,
    required this.storyName,
    required this.widgetName,
    required this.widgetFilePath,
  }) : super(
          name: name,
          importStatement: importStatement,
          dependencies: dependencies,
        );

  /// Obtains a [WidgetbookStoryData] object from classes provided by the
  /// UseCaseResolver
  factory WidgetbookStoryData.fromResolver(
    Element element,
    Element typeElement,
    String storyName,
    String widgetName,
    String widgetFilePath,
  ) {
    return WidgetbookStoryData(
      name: element.name!,
      importStatement: element.importStatement,
      typeDefinition: typeElement.importStatement,
      dependencies: typeElement.dependencies,
      storyName: storyName,
      widgetName: widgetName,
      widgetFilePath: widgetFilePath,
    );
  }

  /// transforms the serializable map into a [WidgetbookStoryData] object.
  factory WidgetbookStoryData.fromMap(Map<String, dynamic> map) {
    return WidgetbookStoryData(
      name: map['name'] as String,
      importStatement: map['importStatement'] as String,
      typeDefinition: map['typeDefinition'] as String,
      dependencies: List<String>.from(map['dependencies'] as Iterable),
      storyName: map['storyName'] as String,
      widgetName: map['widgetName'] as String,
      widgetFilePath: map['widgetFilePath'] as String,
    );
  }

  /// The name of the story.
  /// This name will be displayed in the navigation panel of the Widgetbook
  /// user interface
  final String storyName;

  /// The String version of the Widget's type
  /// [widgetName] will be displayed as a WidgetElement in the Widgetbook.
  final String widgetName;

  final String widgetFilePath;

  final String typeDefinition;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'importStatement': importStatement,
      'typeDefinition': typeDefinition,
      'dependencies': dependencies,
      'storyName': storyName,
      'widgetName': widgetName,
      'widgetFilePath': widgetFilePath,
    };
  }
}
