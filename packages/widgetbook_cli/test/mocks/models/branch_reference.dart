import '../../../bin/git/reference.dart';

const branch = 'branch-ref';
final sha = 'a' * 40;

final branchReference = Reference(
  sha,
  branch,
);
