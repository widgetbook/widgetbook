class SkipReviewResponse {
  const SkipReviewResponse({
    required this.sha,
    required this.state,
    required this.prNumber,
  });

  final String sha;
  final String state;
  final int prNumber;

  // ignore: sort_constructors_first
  factory SkipReviewResponse.fromJson(Map<String, dynamic> json) {
    return SkipReviewResponse(
      sha: json['sha'] as String,
      state: json['state'] as String,
      prNumber: json['prNumber'] as int,
    );
  }
}
