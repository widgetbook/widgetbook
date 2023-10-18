import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  const userName = 'John Doe';
  const repoName = 'widgetbook';
  const sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';

  final ciManager = MockCiManager();
  final platform = MockPlatform();
  final contextManager = ContextManager(
    ciManager: ciManager,
    platform: platform,
  );

  group('$ContextManager', () {
    final repository = MockRepository();
    final environment = FakeEnvironment();

    test('Local', () async {
      ciManager.mock();
      when(() => repository.name).thenReturn(repoName);
      when(() => repository.user).thenAnswer((_) async => userName);

      expectLater(
        contextManager.load(repository, environment),
        completion(
          Context(
            name: 'Local',
            repository: repository,
            environment: environment,
            user: userName,
            project: repoName,
          ),
        ),
      );
    });

    test('Azure', () {
      ciManager.mock(isAzure: true);
      when(() => platform.environment).thenReturn({
        'Agent.Name': userName,
        'Build.Repository.Name': repoName,
      });

      expectLater(
        contextManager.load(repository, environment),
        completion(
          Context(
            name: 'Azure',
            repository: repository,
            environment: environment,
            user: userName,
            project: repoName,
          ),
        ),
      );
    });

    test('Bitbucket', () {
      ciManager.mock(isBitbucket: true);
      when(() => platform.environment).thenReturn({
        'BITBUCKET_STEP_TRIGGERER_UUID': userName,
        'BITBUCKET_REPO_FULL_NAME': repoName,
      });

      expectLater(
        contextManager.load(repository, environment),
        completion(
          Context(
            name: 'Bitbucket',
            repository: repository,
            environment: environment,
            user: userName,
            project: repoName,
          ),
        ),
      );
    });

    test('Codemagic', () {
      ciManager.mock(isCodemagic: true);
      when(() => platform.environment).thenReturn({
        'CM_REPO_SLUG': repoName,
        'CM_COMMIT': userName,
      });

      expectLater(
        contextManager.load(repository, environment),
        completion(
          Context(
            name: 'Codemagic',
            repository: repository,
            environment: environment,
            user: 'Codemagic',
            project: repoName,
            providerSha: userName,
          ),
        ),
      );
    });

    test('GitHub', () {
      ciManager.mock(isGitHub: true);
      when(() => platform.environment).thenReturn({
        'GITHUB_ACTOR': userName,
        'GITHUB_REPOSITORY': repoName,
        'GITHUB_SHA': sha,
      });

      expectLater(
        contextManager.load(repository, environment),
        completion(
          Context(
            name: 'GitHub',
            repository: repository,
            environment: environment,
            user: userName,
            project: repoName,
            providerSha: sha,
          ),
        ),
      );
    });

    test('GitLab', () {
      ciManager.mock(isGitLab: true);
      when(() => platform.environment).thenReturn({
        'GITLAB_USER_NAME': userName,
        'CI_PROJECT_NAME': repoName,
      });

      expectLater(
        contextManager.load(repository, environment),
        completion(
          Context(
            name: 'GitLab',
            repository: repository,
            environment: environment,
            user: userName,
            project: repoName,
          ),
        ),
      );
    });
  });
}
