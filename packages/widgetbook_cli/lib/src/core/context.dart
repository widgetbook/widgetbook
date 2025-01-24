import '../git/git.dart';

/// The [Context] has all the information about the current environment.
/// It is used to determine the current user, project and repository.
class Context {
  Context({
    required this.name,
    required this.repository,
    required this.user,
    required this.project,
    this.providerBranch,
    this.providerSha,
  });

  final String name;
  final Repository? repository;
  final String? user;
  final String? project;
  final String? providerBranch;
  final String? providerSha;

  @override
  bool operator ==(covariant Context other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.repository == repository &&
        other.user == user &&
        other.project == project &&
        other.providerBranch == providerBranch &&
        other.providerSha == providerSha;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        repository.hashCode ^
        user.hashCode ^
        project.hashCode ^
        providerBranch.hashCode ^
        providerSha.hashCode;
  }
}
