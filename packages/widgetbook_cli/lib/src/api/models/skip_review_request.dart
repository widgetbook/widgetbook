import 'api_key.dart';

class SkipReviewRequest {
  const SkipReviewRequest({
    required this.apiKey,
    required this.sha,
    this.reason,
    this.projectName,
  });

  final ApiKey apiKey;
  final String sha;
  final String? reason;
  final String? projectName;

  Map<String, dynamic> toJson() {
    return {
      ...apiKey.toJson(),
      'sha': sha,
      if (reason != null) 'reason': reason,
      if (projectName != null) 'projectName': projectName,
    };
  }
}
