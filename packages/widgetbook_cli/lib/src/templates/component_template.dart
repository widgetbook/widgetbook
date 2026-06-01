import '../analyzer/collectors/widget_info_collector.dart';
import 'template.dart';

class ComponentTemplate extends Template {
  ComponentTemplate(String filename, WidgetInfo widgetInfo)
    : super(
        'lib/${widgetInfo.dirname}/$filename.stories.dart',
        generateContent(filename, widgetInfo),
      );

  static String generateContent(String filename, WidgetInfo widgetInfo) {
    final widgetName = widgetInfo.name;

    // If the widget has no constructors picked up (e.g., all private), emit a
    // single default meta as a starting point. Otherwise emit one meta per
    // public constructor.
    final constructors = widgetInfo.constructors.isEmpty
        ? const [ConstructorInfo(name: null, parameterTypes: [])]
        : widgetInfo.constructors;

    final metaDeclarations = constructors
        .map((c) => _renderMeta(widgetName, c))
        .join('\n');

    final storyDeclarations = constructors
        .map((c) => _renderStoryStub(c))
        .join('\n');

    return '''
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import '${widgetInfo.importPath}';

part '$filename.stories.g.dart';

$metaDeclarations

$storyDeclarations
''';
  }

  static String _renderMeta(String widgetName, ConstructorInfo c) {
    if (c.isDefault) {
      return 'const meta = Meta<$widgetName>();';
    }
    return 'const ${c.name}Meta = Meta<$widgetName>(\n'
        '  constructor: $widgetName.${c.name},\n'
        ');';
  }

  static String _renderStoryStub(ConstructorInfo c) {
    final storyName = c.isDefault ? 'Default' : c.classPrefix;
    final storyType = '_${c.classPrefix}Story';
    final argsType = '_${c.classPrefix}Args';

    if (requiresArgs(c)) {
      return '// TODO: Pass required args here\n'
          '// final \$$storyName = $storyType(\n'
          '//   name: \'$storyName\',\n'
          '//   args: $argsType(),\n'
          '// );';
    }
    return 'final \$$storyName = $storyType(\n'
        '  name: \'$storyName\',\n'
        ');';
  }

  /// A story requires `args` if its constructor has at least one parameter
  /// that is neither first-class supported nor nullable.
  static bool requiresArgs(ConstructorInfo constructor) {
    const supportedTypes = [
      'int',
      'double',
      'String',
      'bool',
      'Color',
      'Duration',
      'DateTime',
    ];

    return constructor.parameterTypes.any(
      (type) => !supportedTypes.contains(type) && !type.endsWith('?'),
    );
  }
}
