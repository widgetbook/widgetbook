import 'package:platform/platform.dart';

import '../git/repository.dart';
import 'ci_manager.dart';
import 'context.dart';

class ContextManager {
  const ContextManager({
    this.platform = const LocalPlatform(),
    this.ciManager = const CiManager(),
  });

  final Platform platform;
  final CiManager ciManager;

  Future<Context?> load(Repository repository) async {
    if (!ciManager.isCI) {
      return Context(
        name: 'Local',
        userName: await repository.user,
        repoName: await repository.name,
      );
    }

    if (ciManager.isAzure) {
      return Context(
        name: 'Azure',
        userName: platform.environment['Agent.Name'],
        repoName: platform.environment['Build.Repository.Name'],
      );
    }

    if (ciManager.isBitbucket) {
      return Context(
        name: 'Bitbucket',
        userName: platform.environment['BITBUCKET_STEP_TRIGGERER_UUID'],
        repoName: platform.environment['BITBUCKET_REPO_FULL_NAME'],
      );
    }

    if (ciManager.isCodemagic) {
      return Context(
        name: 'Codemagic',
        userName: 'Codemagic',
        repoName: platform.environment['CM_REPO_SLUG'],
        providerSha: platform.environment['CM_COMMIT'],
      );
    }

    if (ciManager.isGitHub) {
      return Context(
        name: 'GitHub',
        userName: platform.environment['GITHUB_ACTOR'],
        repoName: platform.environment['GITHUB_REPOSITORY'],
        providerSha: platform.environment['GITHUB_SHA'],
      );
    }

    if (ciManager.isGitLab) {
      return Context(
        name: 'GitLab',
        userName: platform.environment['GITLAB_USER_NAME'],
        repoName: platform.environment['CI_PROJECT_NAME'],
      );
    }

    return null;
  }
}
