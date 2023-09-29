import '../../bin/api/api.dart';
import '../../bin/git/branch_reference.dart';
import '../../bin/models/models.dart';

class TestData {
  static const ciArgsData = CliArgs(
    apiKey: 'apiKey',
    branch: 'branch',
    commit: 'commit',
    gitProvider: 'gitProvider',
    gitHubToken: 'gitHubToken',
    prNumber: 'prNumber',
    baseBranch: 'baseBranch',
    path: 'path',
  );

  static final args = PublishArgs(
    apiKey: 'apiKey',
    branch: 'branch',
    commit: 'commit',
    gitHubToken: 'gitHubToken',
    prNumber: 'prNumber',
    baseBranch: 'baseBranch',
    baseSha: 'a' * 40,
    path: 'path',
    vendor: 'Local',
    repository: 'respository',
    actor: 'John Doe',
  );

  static const ciArgs = CiArgs(
    vendor: 'Local',
    repository: 'respository',
    actor: 'John Doe',
  );

  static final branches = BranchReference(
    'sha',
    'HEAD',
  );

  static const buildResponse = BuildResponse(
    project: 'projectId',
    build: 'buildId',
    status: BuildUploadStatus.success,
    tasks: [],
  );

  static const reviewResponse = ReviewResponse(
    tasks: [],
    review: Review(
      id: 'reviewId',
    ),
  );
}
