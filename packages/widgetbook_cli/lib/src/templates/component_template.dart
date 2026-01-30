import '../analyzer/collectors/widget_info_collector.dart';
import 'template.dart';

class ComponentTemplate extends Template {
  ComponentTemplate(String filename, WidgetInfo widgetInfo)
    : super(
        'lib/${widgetInfo.dirname}/$filename.stories.dart',
        generateContent(filename, widgetInfo),
      );

  static String generateContent(String filename, WidgetInfo widgetInfo) {
    final header =
        '''
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import '${widgetInfo.importPath}';

part '${filename}.stories.g.dart';

const meta = Meta<${widgetInfo.name}>();
''';

    final regularStory = '''
final \$Default = _Story(
  name: 'Default',
);
''';

    final requiredArgsStory = '''
// TODO: Pass required args here
// final \$Default = _Story(
//   name: 'Default',
//   args: _Args(),
// );
''';

    return '''
$header
${requiresArgs(widgetInfo) ? requiredArgsStory : regularStory}
''';
  }

  /// A story requires `args` if it has at least one parameter that is not
  /// first-class supported and not nullable.
  static bool requiresArgs(WidgetInfo widgetInfo) {
    final supportedTypes = [
      'int',
      'double',
      'String',
      'bool',
      'Color',
      'Duration',
      'DateTime',
    ];

    return widgetInfo.parameterTypes.any(
      (type) => !supportedTypes.contains(type) && !type.endsWith('?'),
    );
  }
}
