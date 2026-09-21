import '../api/api.dart';

/// Typed representation of the arguments passed to the review skip command.
class ReviewSkipArgs {
  const ReviewSkipArgs({
    required this.apiKey,
    required this.project,
    required this.prNumber,
    required this.sha,
    required this.reason,
  });

  final ApiKey apiKey;

  /// Name of the Widgetbook Cloud project, required with a [WorkspaceApiKey].
  final String? project;

  final int prNumber;
  final String sha;
  final String? reason;
}
