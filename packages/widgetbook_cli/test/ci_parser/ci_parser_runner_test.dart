import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/models/models.dart';
import '../mocks/command_mocks.dart';

const repositoryName = 'widgetbook';
const actorName = 'John Doe';

void main() {
  late CiParserRunner sut;
  late ArgResults argResults;
  late GitDir gitDir;
  late CiWrapper ciWrapper;
  late PlatformWrapper platformWrapper;

  setUp(() async {
    argResults = MockArgResults();
    gitDir = MockGitDir();
    ciWrapper = MockCiWrapper();
    platformWrapper = MockPlatformWrapper();

    sut = CiParserRunner(
      argResults: argResults,
      gitDir: gitDir,
      ciWrapper: ciWrapper,
      platformWrapper: platformWrapper,
    );
  });

  group('$CiParserRunner', () {
    test(
      'expect instance of $ArgResults',
      () async {
        expect(sut.argResults, equals(argResults));
      },
    );

    test(
      'expect instance of $MockGitDir',
      () async {
        expect(sut.gitDir, equals(gitDir));
      },
    );

    test(
      'returns $CiArgs from $LocalParser',
      () async {
        when(() => ciWrapper.isCI()).thenReturn(true);

        when(() => gitDir.getActorName())
            .thenAnswer((_) => Future.value(actorName));

        when(() => gitDir.getRepositoryName())
            .thenAnswer((_) => Future.value(repositoryName));

        final sut = CiParserRunner(
          argResults: argResults,
          gitDir: gitDir,
        );

        final ciArgs = await sut.getParser()?.getCiArgs();

        expect(ciArgs?.actor, actorName);
        expect(ciArgs?.repository, repositoryName);
        expect(ciArgs?.vendor, 'Local');
      },
    );

    test(
      'returns $CiArgs from $GitLabParser',
      () async {
        when(() => ciWrapper.isCI()).thenReturn(true);
        when(() => ciWrapper.isGitLab()).thenReturn(true);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'CI_PROJECT_NAME',
          ),
        ).thenReturn(repositoryName);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'GITLAB_USER_NAME',
          ),
        ).thenReturn(actorName);

        final ciArgs = await sut.getParser()?.getCiArgs();

        expect(ciArgs?.actor, actorName);
        expect(ciArgs?.repository, repositoryName);
        expect(ciArgs?.vendor, 'GitLab');
      },
    );
    test(
      'returns $CiArgs from $GitHubParser',
      () async {
        when(() => ciWrapper.isCI()).thenReturn(true);
        when(() => ciWrapper.isGithub()).thenReturn(true);
        when(() => ciWrapper.isBitBucket()).thenReturn(false);
        when(() => ciWrapper.isGitLab()).thenReturn(false);
        when(() => ciWrapper.isAzure()).thenReturn(false);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'GITHUB_REPOSITORY',
          ),
        ).thenReturn(repositoryName);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'GITHUB_ACTOR',
          ),
        ).thenReturn(actorName);

        final ciArgs = await sut.getParser()?.getCiArgs();

        expect(ciArgs?.actor, actorName);
        expect(ciArgs?.repository, repositoryName);
        expect(ciArgs?.vendor, 'GitHub');
      },
    );

    test(
      'returns $CiArgs from $AzureParser',
      () async {
        when(() => ciWrapper.isCI()).thenReturn(true);
        when(() => ciWrapper.isAzure()).thenReturn(true);

        when(() => ciWrapper.isBitBucket()).thenReturn(false);
        when(() => ciWrapper.isGitLab()).thenReturn(false);
        when(() => ciWrapper.isGithub()).thenReturn(false);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'Build.Repository.Name',
          ),
        ).thenReturn(repositoryName);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'Agent.Name',
          ),
        ).thenReturn(actorName);

        final ciArgs = await sut.getParser()?.getCiArgs();

        expect(ciArgs?.actor, actorName);
        expect(ciArgs?.repository, repositoryName);
        expect(ciArgs?.vendor, 'Azure');
      },
    );

    test(
      'returns $CiArgs from $BitbucketParser',
      () async {
        when(() => ciWrapper.isCI()).thenReturn(true);
        when(() => ciWrapper.isBitBucket()).thenReturn(true);

        when(() => ciWrapper.isAzure()).thenReturn(false);
        when(() => ciWrapper.isGitLab()).thenReturn(false);
        when(() => ciWrapper.isGithub()).thenReturn(false);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'BITBUCKET_REPO_FULL_NAME',
          ),
        ).thenReturn(repositoryName);

        when(
          () => platformWrapper.environmentVariable(
            variable: 'BITBUCKET_STEP_TRIGGERER_UUID',
          ),
        ).thenReturn(actorName);

        final ciArgs = await sut.getParser()?.getCiArgs();

        expect(ciArgs?.actor, actorName);
        expect(ciArgs?.repository, repositoryName);
        expect(ciArgs?.vendor, 'Bitbucket');
      },
    );
  });
}
