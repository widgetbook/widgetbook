import '../models/widgetbook_data.dart';

/// generates the imports for all the types used in widgetbook.g.dart
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
    ..add('package:widgetbook/widgetbook.dart')
    ..remove('package:widgetbook_annotation/widgetbook_annotation.dart');

  final imports = set.map(_generateImportStatement).toList()
    ..sort((a, b) => a.compareTo(b));

  return imports.join('\n');
}

String _generateImportStatement(String import) {
  return "import '$import';";
}
