import 'package:widgetbook_generator/models/widgetbook_data.dart';

/// generates the imports for all the types used in app.widgetbook.dart
///
/// the code returned likely contains unneccesary imports
/// but this implementation is simple in comparison to a complex approach
String generateImports(
  List<WidgetbookData> datas,
) {
  final set = <String>{};

  for (final data in datas) {
    set
      ..add(data.importStatement)
      ..addAll(data.dependencies);
  }

  set
    ..add('package:flutter/material.dart')
    ..add('package:widgetbook/widgetbook.dart');

  return set.map(_generateImportStatement).join('\n');
}

String _generateImportStatement(String import) {
  return "import '$import';";
}
