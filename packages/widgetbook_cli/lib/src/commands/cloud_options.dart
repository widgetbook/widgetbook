import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../core/core.dart';

extension CloudOptions on ArgParser {
  void addProjectOption() {
    addOption(
      'project',
      help:
          'Name of the project on Widgetbook Cloud. '
          'Optional when the API key reaches exactly one project.',
    );
  }

  void addApiUrlOption() {
    addOption(
      'api-url',
      help: 'Base URL of the Widgetbook Cloud API. Defaults to $BASE_API_URL.',
    );
  }
}

/// Parses the `api-url` option declared by [CloudOptions.addApiUrlOption],
/// returning `null` when it was not passed.
Uri? parseApiUrlOption(ArgResults results) {
  final value = results['api-url'] as String?;
  if (value == null) return null;

  final url = Uri.tryParse(value);
  final isValid =
      url != null &&
      (url.scheme == 'http' || url.scheme == 'https') &&
      url.host.isNotEmpty &&
      !url.hasQuery &&
      !url.hasFragment;

  if (!isValid) {
    throw CliException(
      'The --api-url option must be an http or https URL, got "$value".',
      ExitCode.usage.code,
    );
  }

  return url;
}

/// Parses the `project` option declared by [CloudOptions.addProjectOption],
/// which must not be blank when passed.
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
