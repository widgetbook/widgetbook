import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/core/context.dart';
import '../../bin/core/context_manager.dart';
import '../utils/mocks.dart';

void main() {
  const userName = 'John Doe';
  const repoName = 'widgetbook';
  const sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';

  final ciManager = MockCiManager();
  final platform = MockPlatform();
  final gitManager = MockGitManager();
  final contextManager = ContextManager(
    ciManager: ciManager,
    platform: platform,
    gitManager: gitManager,
  );

  group('$ContextManager', () {
    const workingDir = './';

    test('Local', () async {
      final repository = MockRepository();

      ciManager.mock(isCI: false);
      when(() => gitManager.load(any())).thenReturn(repository);
      when(() => repository.user).thenAnswer((_) async => userName);
      when(() => repository.name).thenAnswer((_) async => repoName);

      expectLater(
        contextManager.load(workingDir),
        completion(
          Context(
            name: 'Local',
            workingDir: workingDir,
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
        contextManager.load(workingDir),
        completion(
          Context(
            name: 'Azure',
            workingDir: workingDir,
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
        contextManager.load(workingDir),
        completion(
          Context(
            name: 'Bitbucket',
            workingDir: workingDir,
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
        contextManager.load(workingDir),
        completion(
          Context(
            name: 'Codemagic',
            workingDir: workingDir,
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
        contextManager.load(workingDir),
        completion(
          Context(
            name: 'GitHub',
            workingDir: workingDir,
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
        contextManager.load(workingDir),
        completion(
          Context(
            name: 'GitLab',
            workingDir: workingDir,
            user: userName,
            project: repoName,
          ),
        ),
      );
    });
  });
}
