import 'package:meta/meta.dart';

import '../git/git.dart';

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
    this.baseBranch,
    this.visualDiff = false,
  });

  final String apiKey;
  final String branch;
  final String commit;
  final String path;
  final String vendor;
  final String actor;
  final String repository;
  final Reference? baseBranch;

  @experimental
  final bool visualDiff;

  bool get hasReview => baseBranch != null;

  @override
  bool operator ==(covariant PublishArgs other) {
    if (identical(this, other)) return true;

    return other.apiKey == apiKey &&
        other.branch == branch &&
        other.commit == commit &&
        other.path == path &&
        other.vendor == vendor &&
        other.actor == actor &&
        other.repository == repository &&
        other.baseBranch == baseBranch &&
        other.visualDiff == visualDiff;
  }

  @override
  int get hashCode {
    return apiKey.hashCode ^
        branch.hashCode ^
        commit.hashCode ^
        path.hashCode ^
        vendor.hashCode ^
        actor.hashCode ^
        repository.hashCode ^
        baseBranch.hashCode ^
        visualDiff.hashCode;
  }
}
