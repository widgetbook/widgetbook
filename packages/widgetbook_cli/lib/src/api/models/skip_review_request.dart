class SkipReviewRequest {
  const SkipReviewRequest({
    required this.sha,
    this.reason,
  });

  final String sha;
  final String? reason;

  Map<String, dynamic> toJson() {
    return {
      'sha': sha,
      if (reason != null) 'reason': reason,
    };
  }
}
