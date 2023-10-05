import '../../bin/api/api.dart';
import '../../bin/context/context.dart';
import '../../bin/git/reference.dart';
import '../../bin/models/models.dart';

class TestData {
  static final args = PublishArgs(
    apiKey: 'apiKey',
    branch: 'branch',
    commit: 'commit',
    gitHubToken: 'gitHubToken',
    prNumber: 'prNumber',
    baseBranch: Reference('a' * 40, 'baseBranch'),
    path: 'path',
    vendor: 'Local',
    repository: 'repository',
    actor: 'John Doe',
  );

  static const ciArgs = Context(
    name: 'Local',
    repoName: 'repository',
    userName: 'John Doe',
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
