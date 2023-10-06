import '../git/repository.dart';

class Context {
  Context({
    required this.name,
    required this.workingDir,
    required this.user,
    required this.project,
    this.providerSha,
  }) : repository = Repository.load(workingDir);

  final String name;
  final String workingDir;
  final String? user;
  final String? project;
  final String? providerSha;
  final Repository repository;

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

  Context copyWith({
    String? name,
    String? workingDir,
    String? user,
    String? project,
    String? providerSha,
  }) {
    return Context(
      name: name ?? this.name,
      workingDir: workingDir ?? this.workingDir,
      user: user ?? this.user,
      project: project ?? this.project,
      providerSha: providerSha ?? this.providerSha,
    );
  }
}
