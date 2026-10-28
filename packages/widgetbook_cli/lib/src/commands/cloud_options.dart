import 'package:args/args.dart';

import '../api/api.dart';

extension CloudOptions on ArgParser {
  void addApiUrlOption(WidgetbookHttpClient cloudClient) {
    addOption(
      'api-url',
      help: 'Base URL of the Widgetbook Cloud API. Defaults to $BASE_API_URL.',
      callback: (url) {
        if (url == null) return;
        cloudClient.client.options.baseUrl = url.endsWith('/') ? url : '$url/';
      },
    );
  }
}
