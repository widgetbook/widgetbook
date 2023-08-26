import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as path;

const widgetbookUrl = 'package:widgetbook/widgetbook.dart';

/// Same as [refer] but uses [widgetbookUrl] as default url.
Reference referWidgetbook(String symbol) {
  return refer(symbol, widgetbookUrl);
}

/// Same as [refer] but converts [url] to a relative path.
///
/// If the file is located outside the lib directory, then the [url] will
/// be an "asset:" uri. In this case, it is converted to a relative path,
/// relative to the [from] directory.
Reference referRelative(
  String symbol,
  String url,
  String from,
) {
  final uri = Uri.parse(url);
  final relativeUrl = path.relative(
    uri.path,
    from: from,
  );

  return refer(
    symbol,
    uri.scheme == 'asset' ? relativeUrl : url,
  );
}
