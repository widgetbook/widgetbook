/// An API key that authenticates requests to Widgetbook Cloud.
sealed class ApiKey {
  const ApiKey(this.value);

  /// Parses [value] into a [WorkspaceApiKey] if it has the
  /// [WorkspaceApiKey.prefix], or into a [ProjectApiKey] otherwise.
  factory ApiKey.parse(String value) {
    return value.startsWith(WorkspaceApiKey.prefix)
        ? WorkspaceApiKey(value)
        : ProjectApiKey(value);
  }

  final String value;

  /// Headers that authenticate a request with this key.
  Map<String, String> toHeaders();

  /// Request body fields that authenticate a request with this key.
  Map<String, dynamic> toJson();
}

/// An API key that grants access to all projects of a workspace. As it does
/// not identify a project on its own, requests that target a project also
/// have to name it.
class WorkspaceApiKey extends ApiKey {
  const WorkspaceApiKey(super.value);

  static const prefix = 'widgetbook_ws_';

  @override
  Map<String, String> toHeaders() => {'Authorization': 'Bearer $value'};

  @override
  Map<String, dynamic> toJson() => const {};
}

/// An API key that grants access to a single project.
class ProjectApiKey extends ApiKey {
  const ProjectApiKey(super.value);

  @override
  Map<String, String> toHeaders() => const {};

  @override
  Map<String, dynamic> toJson() => {'apiKey': value};
}
