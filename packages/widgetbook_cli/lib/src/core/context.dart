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
    this.providerPrNumber,
    this.providerPrHeadSha,
  });

  final String name;
  final Repository? repository;
  final String? user;
  final String? project;
  final String? providerBranch;
  final String? providerSha;

  /// Number of the pull request the current job runs for, if any.
  final int? providerPrNumber;

  /// Head commit of the pull request the current job runs for.
  ///
  /// Deliberately separate from [providerSha]: on a pull request event most
  /// providers expose the *merge* commit, which does not exist on the branch
  /// and is not what Widgetbook tracks as the head.
  final String? providerPrHeadSha;

  @override
  bool operator ==(covariant Context other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.repository == repository &&
        other.user == user &&
        other.project == project &&
        other.providerBranch == providerBranch &&
        other.providerSha == providerSha &&
        other.providerPrNumber == providerPrNumber &&
        other.providerPrHeadSha == providerPrHeadSha;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        repository.hashCode ^
        user.hashCode ^
        project.hashCode ^
        providerBranch.hashCode ^
        providerSha.hashCode ^
        providerPrNumber.hashCode ^
        providerPrHeadSha.hashCode;
  }
}
