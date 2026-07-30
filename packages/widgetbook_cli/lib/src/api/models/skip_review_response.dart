class SkipReviewResponse {
  const SkipReviewResponse({
    required this.context,
    required this.sha,
    required this.state,
    required this.prNumber,
  });

  /// Commit status context, e.g. `Widgetbook Review (my-app)`. This is the
  /// exact name to use in a branch protection rule.
  final String context;
  final String sha;
  final String state;
  final int prNumber;

  // ignore: sort_constructors_first
  factory SkipReviewResponse.fromJson(Map<String, dynamic> json) {
    return SkipReviewResponse(
      context: json['context'] as String,
      sha: json['sha'] as String,
      state: json['state'] as String,
      prNumber: json['prNumber'] as int,
    );
  }
}
