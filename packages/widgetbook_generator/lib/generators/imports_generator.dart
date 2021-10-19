import 'package:widgetbook_generator/models/widgetbook_data.dart';

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
