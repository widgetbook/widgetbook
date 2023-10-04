import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/context/context.dart';
import '../../bin/context/context_manager.dart';
import '../mocks/command_mocks.dart';

void main() {
  const userName = 'John Doe';
  const repoName = 'widgetbook';
  const sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';

  final repository = MockRepository();
  final ciManager = MockCiManager();
  final platform = MockPlatform();
  final contextManager = ContextManager(
    ciManager: ciManager,
    platform: platform,
  );

  group('$ContextManager', () {
    test('Local', () async {
      ciManager.mock(isCI: false);
      when(() => repository.user).thenAnswer((_) async => userName);
      when(() => repository.name).thenAnswer((_) async => repoName);

      expectLater(
        contextManager.load(repository),
        completion(
          Context(
            name: 'Local',
            userName: await repository.user,
            repoName: await repository.name,
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
        contextManager.load(repository),
        completion(
          const Context(
            name: 'Azure',
            userName: userName,
            repoName: repoName,
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
        contextManager.load(repository),
        completion(
          const Context(
            name: 'Bitbucket',
            userName: userName,
            repoName: repoName,
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
        contextManager.load(repository),
        completion(
          const Context(
            name: 'Codemagic',
            userName: 'Codemagic',
            repoName: repoName,
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
        contextManager.load(repository),
        completion(
          const Context(
            name: 'GitHub',
            userName: userName,
            repoName: repoName,
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
        contextManager.load(repository),
        completion(
          const Context(
            name: 'GitLab',
            userName: userName,
            repoName: repoName,
          ),
        ),
      );
    });
  });
}
