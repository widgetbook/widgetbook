class SkipReviewRequest {
  const SkipReviewRequest({
    required this.apiKey,
    required this.sha,
    this.reason,
  });

  final String apiKey;
  final String sha;
  final String? reason;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'sha': sha,
      if (reason != null) 'reason': reason,
    };
  }
}
