import 'dart:convert';

import '../models/widgetbook_data.dart';

extension JsonListFormatter on List<WidgetbookData> {
  String toJson() => const JsonEncoder.withIndent('  ')
      .convert(map((data) => data.toJson()).toList());
}
