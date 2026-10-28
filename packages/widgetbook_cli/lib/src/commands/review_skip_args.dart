/// Typed representation of the arguments passed to the review skip command.
class ReviewSkipArgs {
  const ReviewSkipArgs({
    required this.apiKey,
    required this.prNumber,
    required this.sha,
    required this.reason,
  });

  final String apiKey;
  final int prNumber;
  final String sha;
  final String? reason;
}
