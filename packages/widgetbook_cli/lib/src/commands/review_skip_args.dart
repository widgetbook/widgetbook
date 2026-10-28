/// Typed representation of the arguments passed to the review skip command.
class ReviewSkipArgs {
  const ReviewSkipArgs({
    required this.apiKey,
    required this.project,
    required this.prNumber,
    required this.sha,
    required this.reason,
  });

  final String apiKey;

  /// Name of the Widgetbook Cloud project, or `null` to use the only project
  /// the [apiKey] reaches.
  final String? project;

  final int prNumber;
  final String sha;
  final String? reason;
}
