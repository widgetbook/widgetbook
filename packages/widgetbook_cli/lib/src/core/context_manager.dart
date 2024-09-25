import 'package:platform/platform.dart';

import '../git/git.dart';
import '../utils/utils.dart';
import 'context.dart';
import 'environment.dart';

class ContextManager {
  const ContextManager({
    this.platform = const LocalPlatform(),
    this.ciManager = const CiManager(),
  });

  final Platform platform;
  final CiManager ciManager;

  /// Returns the relevant [Context] for the current environment.
  /// The [Context] is based on the if the current environment is a CI provider
  /// or a local one.
  Future<Context> load(
    Repository? repository,
    Environment environment,
  ) async {
    if (ciManager.isAzure) {
      return Context(
        name: 'Azure',
        repository: repository,
        environment: environment,
        user: platform.environment['BUILD_SOURCEVERSIONAUTHOR'],
        project: platform.environment['BUILD_REPOSITORY_NAME'],
      );
    }

    if (ciManager.isBitbucket) {
      return Context(
        name: 'Bitbucket',
        repository: repository,
        environment: environment,
        user: platform.environment['BITBUCKET_STEP_TRIGGERER_UUID'],
        project: platform.environment['BITBUCKET_REPO_FULL_NAME'],
      );
    }

    if (ciManager.isCodemagic) {
      return Context(
        name: 'Codemagic',
        repository: repository,
        environment: environment,
        user: 'Codemagic',
        project: platform.environment['CM_REPO_SLUG'],
        providerSha: platform.environment['CM_COMMIT'],
      );
    }

    if (ciManager.isGitHub) {
      return Context(
        name: 'GitHub',
        repository: repository,
        environment: environment,
        user: platform.environment['GITHUB_ACTOR'],
        project: platform.environment['GITHUB_REPOSITORY'],
        providerSha: platform.environment['GITHUB_SHA'],
      );
    }

    if (ciManager.isGitLab) {
      return Context(
        name: 'GitLab',
        repository: repository,
        environment: environment,
        user: platform.environment['GITLAB_USER_NAME'],
        project: platform.environment['CI_PROJECT_NAME'],
      );
    }

    // For unknown CI providers and local environments
    return Context(
      name: ciManager.vendor?.name ?? 'Local',
      repository: repository,
      environment: environment,
      user: await repository?.user,
      project: repository?.name,
    );
  }
}
