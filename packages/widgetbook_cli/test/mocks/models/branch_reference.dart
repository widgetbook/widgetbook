import '../../../bin/git/branch_reference.dart';

const branch = 'branch-ref';
final sha = 'a' * 40;

final branchReference = BranchReference(
  sha,
  branch,
);
