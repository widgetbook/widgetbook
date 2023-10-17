import '../git/git.dart';
import 'environment.dart';

/// The [Context] has all the information about the current environment.
/// It is used to determine the current user, project and repository.
class Context {
  Context({
    required this.name,
    required this.repository,
    required this.environment,
    required this.user,
    required this.project,
    this.providerSha,
  });

  final String name;
  final Repository? repository;
  final Environment environment;
  final String? user;
  final String? project;
  final String? providerSha;

  @override
  bool operator ==(covariant Context other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.repository == repository &&
        other.environment == environment &&
        other.user == user &&
        other.project == project &&
        other.providerSha == providerSha;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        repository.hashCode ^
        environment.hashCode ^
        user.hashCode ^
        project.hashCode ^
        providerSha.hashCode;
  }
}
