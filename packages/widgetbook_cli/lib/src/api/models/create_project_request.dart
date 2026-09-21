import 'api_key.dart';

class CreateProjectRequest {
  const CreateProjectRequest({
    required this.apiKey,
    required this.name,
  });

  final WorkspaceApiKey apiKey;
  final String name;

  Map<String, dynamic> toJson() {
    return {
      ...apiKey.toJson(),
      'name': name,
    };
  }
}
