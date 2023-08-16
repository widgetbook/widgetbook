import '../../bin/git/branch_reference.dart';
import '../../bin/models/build_upload_response.dart';
import '../../bin/models/models.dart';
import '../../bin/models/publish_args.dart';

class TestData {
  static final ciArgsData = CliArgs(
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
    gitProvider: 'gitProvider',
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

  static BuildUploadResponse uploadBuildInfo = BuildUploadResponse(
    project: 'projectId',
    build: 'buildId',
    status: BuildUploadStatus.success,
    tasks: [],
  );

  static final ReviewData reviewData = ReviewData(
    useCases: [],
    buildId: 'buildId',
    projectId: 'projectId',
    baseSha: 'baseSha',
  );
}
