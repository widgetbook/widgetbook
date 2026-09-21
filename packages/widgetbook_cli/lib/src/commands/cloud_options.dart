import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../api/cloud_exception.dart';
import '../core/core.dart';

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

/// Parses the `--api-key` [value], making sure that a workspace API key comes
/// with a [project], as a workspace API key does not identify one on its own.
ApiKey parseApiKey(String value, {required String? project}) {
  final apiKey = ApiKey.parse(value);

  if (apiKey is WorkspaceApiKey &&
      (project == null || project.trim().isEmpty)) {
    throw CliException(
      'A workspace API key needs --project <name>.',
      ExitCode.usage.code,
    );
  }

  return apiKey;
}

extension UnknownProjectHint on CloudException {
  /// Replaces the error for a [project] that does not exist in the workspace
  /// with how to create it.
  CliException withProjectHint(String? project) {
    final isUnknownProject =
        statusCode == 422 && detail.startsWith('No project named');

    if (project == null || !isUnknownProject) return this;

    return CliException(
      "No project named '$project'. "
      'Create it with: widgetbook cloud project create --project $project',
      exitCode,
    );
  }
}
