/// Typed representation of the arguments passed to the publish command.
class PublishArgs {
  const PublishArgs({
    required this.apiKey,
    required this.branch,
    required this.commit,
    required this.path,
    required this.vendor,
    required this.actor,
    required this.repository,
  });

  final String apiKey;
  final String branch;
  final String commit;
  final String path;
  final String vendor;
  final String actor;
  final String repository;

  @override
  bool operator ==(covariant PublishArgs other) {
    if (identical(this, other)) return true;

    return other.apiKey == apiKey &&
        other.branch == branch &&
        other.commit == commit &&
        other.path == path &&
        other.vendor == vendor &&
        other.actor == actor &&
        other.repository == repository;
  }

  @override
  int get hashCode {
    return apiKey.hashCode ^
        branch.hashCode ^
        commit.hashCode ^
        path.hashCode ^
        vendor.hashCode ^
        actor.hashCode ^
        repository.hashCode;
  }
}
