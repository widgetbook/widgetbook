import 'commit_reference.dart';

const _localBranchPrefix = r'refs/heads/';
const _remoteBranchPrefix = r'refs/remotes/';

class BranchReference extends CommitReference {
  /// The name of the associated branch.
  ///
  /// When in the detached head state, the value may be "HEAD". In this case
  /// [isHead] is also `true`.
  String get branchName {
    if (reference.startsWith(_localBranchPrefix)) {
      return reference.substring(_localBranchPrefix.length);
    }
    if (reference.startsWith(_remoteBranchPrefix)) {
      return reference.substring(_remoteBranchPrefix.length);
    }

    return reference;
  }

  factory BranchReference(String sha, String reference) =>
      BranchReference._internal(sha, reference);

  BranchReference._internal(String sha, String reference)
      : super(sha, reference);

  /// Returns `true` if the current checked out commit is in a detached head
  /// state.
  ///
  /// See https://git-scm.com/docs/git-checkout#_detached_head
  bool get isHead => branchName == 'HEAD';

  bool get isHeads => reference.startsWith(_localBranchPrefix);

  bool get isRemote => reference.startsWith(_remoteBranchPrefix);

  @override
  String toString() => 'BranchReference: $branchName  $sha  ($reference)';
}
