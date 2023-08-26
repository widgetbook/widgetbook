import 'package:code_builder/code_builder.dart';

const widgetbookUrl = 'package:widgetbook/widgetbook.dart';

/// Same as [refer] but uses [widgetbookUrl] as default url.
Reference referWidgetbook(String symbol) {
  return refer(symbol, widgetbookUrl);
}
