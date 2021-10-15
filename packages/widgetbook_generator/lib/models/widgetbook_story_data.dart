import 'package:analyzer/dart/element/element.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/models/widgetbook_data.dart';

class WidgetbookStoryData extends WidgetbookData {
  final String storyName;
  final String widgetName;

  WidgetbookStoryData({
    required String name,
    required String importStatement,
    required List<String> dependencies,
    required this.storyName,
    required this.widgetName,
  }) : super(
          name: name,
          importStatement: importStatement,
          dependencies: dependencies,
        );

  factory WidgetbookStoryData.fromResolver(
    Element element,
    String storyName,
    String widgetName,
  ) {
    return WidgetbookStoryData(
      name: element.name!,
      importStatement: element.importStatement,
      dependencies: element.dependencies,
      storyName: storyName,
      widgetName: widgetName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'importStatement': importStatement,
      'dependencies': dependencies,
      'storyName': storyName,
      'widgetName': widgetName,
    };
  }

  factory WidgetbookStoryData.fromMap(Map<String, dynamic> map) {
    return WidgetbookStoryData(
      name: map['name'],
      importStatement: map['importStatement'],
      dependencies: List<String>.from(map['dependencies']),
      storyName: map['storyName'],
      widgetName: map['widgetName'],
    );
  }
}
