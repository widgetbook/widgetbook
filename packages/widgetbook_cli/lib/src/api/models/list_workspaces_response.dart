import 'workspace_response.dart';

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
