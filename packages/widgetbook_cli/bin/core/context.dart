import '../git/repository.dart';
import 'environment.dart';

class Context {
  Context({
    required this.name,
    required this.workingDir,
    required this.environment,
    required this.user,
    required this.project,
    this.providerSha,
  }) : repository = Repository.load(workingDir);

  final String name;
  final String workingDir;
  final Environment environment;
  final String? user;
  final String? project;
  final String? providerSha;
  final Repository repository;

  @override
  bool operator ==(covariant Context other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.workingDir == workingDir &&
        other.environment == environment &&
        other.user == user &&
        other.project == project &&
        other.providerSha == providerSha;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        workingDir.hashCode ^
        environment.hashCode ^
        user.hashCode ^
        project.hashCode ^
        providerSha.hashCode;
  }

  Context copyWith({
    String? name,
    String? workingDir,
    Environment? env,
    String? user,
    String? project,
    String? providerSha,
  }) {
    return Context(
      name: name ?? this.name,
      workingDir: workingDir ?? this.workingDir,
      environment: env ?? this.environment,
      user: user ?? this.user,
      project: project ?? this.project,
      providerSha: providerSha ?? this.providerSha,
    );
  }
}
