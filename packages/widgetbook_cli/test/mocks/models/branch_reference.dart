import 'package:widgetbook_git/widgetbook_git.dart';

const branch = 'branch-ref';
final sha = 'a' * 40;

final branchReference = BranchReference(
  sha,
  branch,
);
