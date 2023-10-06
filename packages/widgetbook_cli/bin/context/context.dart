import '../git/repository.dart';

class Context {
  const Context({
    required this.name,
    required this.workingDir,
    required this.user,
    required this.project,
    this.providerSha,
  });

  final String name;
  final String workingDir;
  final String? user;
  final String? project;
  final String? providerSha;

  Repository get repository => Repository.load(workingDir);

  @override
  bool operator ==(covariant Context other) {
    if (identical(this, other)) return true;

    return other.workingDir == workingDir &&
        other.name == name &&
        other.user == user &&
        other.project == project &&
        other.providerSha == providerSha;
  }

  @override
  int get hashCode {
    return workingDir.hashCode ^
        name.hashCode ^
        user.hashCode ^
        project.hashCode ^
        providerSha.hashCode;
  }
}
