class WorkspaceResponse {
  const WorkspaceResponse({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  // ignore: sort_constructors_first
  factory WorkspaceResponse.fromJson(Map<String, dynamic> json) {
    return WorkspaceResponse(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

class ListWorkspacesResponse {
  const ListWorkspacesResponse({
    required this.workspaces,
  });

  final List<WorkspaceResponse> workspaces;

  // ignore: sort_constructors_first
  factory ListWorkspacesResponse.fromJson(Map<String, dynamic> json) {
    return ListWorkspacesResponse(
      workspaces: (json['workspaces'] as List<dynamic>)
          .map(
            (workspace) =>
                WorkspaceResponse.fromJson(workspace as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
