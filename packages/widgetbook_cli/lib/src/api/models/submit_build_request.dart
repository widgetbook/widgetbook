import 'api_key.dart';

class SubmitBuildRequest {
  const SubmitBuildRequest({
    required this.apiKey,
    required this.buildId,
  });

  final ApiKey apiKey;
  final String buildId;

  Map<String, dynamic> toJson() {
    return {
      ...apiKey.toJson(),
      'buildId': buildId,
    };
  }
}
