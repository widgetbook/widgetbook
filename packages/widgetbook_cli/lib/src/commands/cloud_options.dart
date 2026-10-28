import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../core/core.dart';

/// Reads the `--project` option, which must not be blank when passed.
String? parseProjectOption(ArgResults results) {
  final project = results['project'] as String?;

  if (project != null && project.trim().isEmpty) {
    throw CliException(
      'The option project must not be empty.',
      ExitCode.usage.code,
    );
  }

  return project;
}

extension CloudOptions on ArgParser {
  void addApiKeyOption() {
    addOption(
      'api-key',
      help: 'API key from your Widgetbook Cloud workspace settings',
      mandatory: true,
    );
  }

  void addProjectOption() {
    addOption(
      'project',
      help:
          'Name of the project on Widgetbook Cloud. '
          'Optional when the API key reaches exactly one project.',
    );
  }

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
