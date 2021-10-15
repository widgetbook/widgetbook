import 'dart:convert';

import 'package:widgetbook_generator/models/widgetbook_data.dart';

extension JsonListExtension on List<WidgetbookData> {
  String toJson() => JsonEncoder.withIndent('  ')
      .convert(map((data) => data.toMap()).toList());
}
