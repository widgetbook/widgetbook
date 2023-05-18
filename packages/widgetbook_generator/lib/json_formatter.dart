import 'dart:convert';

import 'models/widgetbook_data.dart';

extension JsonListExtension on List<WidgetbookData> {
  String toJson() => const JsonEncoder.withIndent('  ')
      .convert(map((data) => data.toJson()).toList());
}
