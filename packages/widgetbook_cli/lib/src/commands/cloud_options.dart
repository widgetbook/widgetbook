import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../api/api.dart';
import '../core/core.dart';

extension CloudOptions on ArgParser {
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
