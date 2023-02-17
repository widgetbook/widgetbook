import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

import '../../bin/api/widgetbook_http_client.dart';
import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/commands/commands.dart';
import '../../bin/git/git_wrapper.dart';
import '../../bin/helpers/helpers.dart';
import '../../bin/models/models.dart';
import '../../bin/models/publish_args.dart';
import '../../bin/review/devices/device_parser.dart';
import '../../bin/review/locales/locales_parser.dart';
import '../../bin/review/text_scale_factors/text_scale_factor_parser.dart';
import '../../bin/review/themes/theme_parser.dart';
import '../../bin/std/stdin_wrapper.dart';
import '../helpers/test_data.dart';
import '../mocks/mocks.dart';
import '../mocks/models/models.dart';

class FakeFile extends Fake implements File {}

class FakeCreateBuildRequest extends Fake implements CreateBuildRequest {}

class FakeReviewData extends Fake implements ReviewData {}

class FakeDirectory extends Fake implements Directory {}

void main() {
  const apiKey = 'Api-Key';
  const gitProvider = 'Local';
  const path = 'path';
  const branch = 'branch';
  const commit = 'commit';

  group('$PublishCommand', () {
    late Logger logger;
    late GitWrapper gitWrapper;
    late GitDir gitDir;
    late CiWrapper ciWrapper;
    late StdInWrapper stdInWrapper;
    late ArgResults argResults;
    late PublishCommand publishCommand;
    late WidgetbookHttpClient widgetbookHttpClient;
    late WidgetbookZipEncoder widgetbookZipEncoder;
    late LocalFileSystem localFileSystem;
    late ThemeParser themeParser;
    late LocaleParser localeParser;
    late DeviceParser deviceParser;
    late TextScaleFactorParser textScaleFactorsParser;
    late Progress progress;
    final tempDir = const LocalFileSystem().currentDirectory;

    Progress publishProgress() => logger.progress(
          'Uploading build',
        );

    setUp(() async {
      logger = MockLogger();
      gitWrapper = MockGitWrapper();
      gitDir = MockGitDir();
      argResults = MockArgResults();
      ciWrapper = MockCiWrapper();
      stdInWrapper = MockStdInWrapper();
      widgetbookHttpClient = MockWidgetbookHttpClient();
      widgetbookZipEncoder = MockWidgetbookZipEncoder();
      localFileSystem = MockLocalFileSystem();
      themeParser = MockThemeParser();
      progress = MockProgress();

      localeParser = MockLocaleParser();
      deviceParser = MockDeviceParser();
      textScaleFactorsParser = MockTextScaleFactorParser();
      when(() => logger.progress(any<String>())).thenReturn(progress);
      publishCommand = PublishCommand(
        logger: logger,
        widgetbookHttpClient: widgetbookHttpClient,
      )..testArgResults = argResults;

      when(() => argResults['api-key'] as String).thenReturn(apiKey);
      when(() => argResults['git-provider'] as String).thenReturn(gitProvider);

      registerFallbackValue(FakeFile());
      registerFallbackValue(FakeCreateBuildRequest());
      registerFallbackValue(FakeReviewData());
      registerFallbackValue(FakeDirectory());
    });

    test('can be instantiated without any parameters', () {
      expect(PublishCommand.new, returnsNormally);
    });

    group(
      'getBaseBranch',
      () {
        final branchRefA = BranchReference(
          '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf',
          'refs/heads/a',
        );
        final branchRefB = BranchReference(
          'f1c882189d0b341e435a58992c6b78a6a3f5ebfc',
          'refs/heads/b',
        );
        final branchRefC = BranchReference(
          '20dbdee64ee73e4be43b9c949492e05437d0e5dc',
          'refs/remotes/origin/c',
        );
        final branchRefD = BranchReference(
          'd4b6472e1566eb2c9897e4fc4d8c4858628bca01',
          'refs/remotes/origin/d',
        );

        setUp(
          () {
            when(
              () => gitDir.fetch(),
            ).thenAnswer((_) => Future.value());
          },
        );

        group('without branches', () {
          setUp(() {
            when(() => gitDir.allBranches()).thenAnswer(
              (_) => Future.value(
                [],
              ),
            );
          });

          test(
            "returns null when invoked with 'a'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'a',
                sha: null,
              );
              expect(branch, isNull);
            },
          );

          test(
            "returns null when invoked with 'refs/heads/a'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'refs/heads/a',
                sha: null,
              );
              expect(branch, isNull);
            },
          );

          test(
            "returns null when invoked with 'c'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'c',
                sha: null,
              );
              expect(branch, isNull);
            },
          );

          test(
            "returns null when invoked with 'refs/remotes/c'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'refs/remotes/c',
                sha: null,
              );
              expect(branch, isNull);
            },
          );
        });

        group(
          'with only remote branches',
          () {
            setUp(() {
              when(() => gitDir.allBranches()).thenAnswer(
                (_) => Future.value(
                  [
                    branchRefC,
                    branchRefD,
                  ],
                ),
              );
            });

            test(
              "returns 'refs/origin/c' with SHA when invoked "
              "with 'refs/heads/c'",
              () async {
                final branch = await publishCommand.getBaseBranch(
                  gitDir: gitDir,
                  branch: 'refs/heads/c',
                  sha: null,
                );
                expect(branch, equals(branchRefC));
              },
            );
          },
        );

        group('with existing branches', () {
          setUp(() {
            when(() => gitDir.allBranches()).thenAnswer(
              (_) => Future.value(
                [
                  branchRefA,
                  branchRefB,
                  branchRefC,
                  branchRefD,
                ],
              ),
            );
          });

          test(
            "returns 'refs/heads/a' with SHA when invoked with 'a'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'a',
                sha: null,
              );
              expect(branch, equals(branchRefA));
            },
          );

          test(
            "returns 'refs/heads/a' with SHA when invoked with 'refs/heads/a'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'refs/heads/a',
                sha: null,
              );
              expect(branch, equals(branchRefA));
            },
          );

          test(
            "returns 'refs/remotes/c' with SHA when invoked with 'c'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'c',
                sha: null,
              );
              expect(branch, equals(branchRefC));
            },
          );

          test(
            "returns 'refs/remotes/c' with SHA when invoked with 'refs/remotes/c'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                gitDir: gitDir,
                branch: 'refs/remotes/c',
                sha: null,
              );
              expect(branch, equals(branchRefC));
            },
          );
        });
      },
    );

    group(
      '.checkIfPathIsGitDirectory',
      () {
        late PublishCommand command;
        setUp(() {
          when(() => argResults['path'] as String).thenReturn('/');
          command = PublishCommand(
            logger: logger,
            gitWrapper: gitWrapper,
          )..testArgResults = argResults;
        });

        test(
          'completes when isGitDir returns true',
          () async {
            when(() => gitWrapper.isGitDir('/')).thenAnswer(
              (_) => Future.value(true),
            );

            expect(
              command.checkIfPathIsGitDirectory('/'),
              completes,
            );
          },
        );

        test(
          'throws $GitDirectoryNotFound when isGitDir returns false',
          () async {
            when(() => gitWrapper.isGitDir('/')).thenAnswer(
              (_) => Future.value(false),
            );

            expect(
              command.checkIfPathIsGitDirectory('/'),
              throwsA(const TypeMatcher<GitDirectoryNotFound>()),
            );
          },
        );
      },
    );

    group(
      '.checkIfWorkingTreeIsClean',
      () {
        late PublishCommand command;
        late GitDir gitDir;
        setUp(() {
          command = PublishCommand(
            logger: logger,
            stdInWrapper: stdInWrapper,
          )..testArgResults = argResults;
          gitDir = MockGitDir();
        });

        test(
          'completes when working dir is clean',
          () async {
            when(
              gitDir.isWorkingTreeClean,
            ).thenAnswer((_) => Future.value(true));

            expect(
              command.checkIfWorkingTreeIsClean(gitDir),
              completes,
            );
          },
        );

        test(
          'completes when environment has no terminal',
          () async {
            when(
              gitDir.isWorkingTreeClean,
            ).thenAnswer((_) => Future.value(false));
            when(() => stdInWrapper.hasTerminal).thenReturn(false);

            expect(
              command.checkIfWorkingTreeIsClean(gitDir),
              completes,
            );
          },
        );

        test(
          'throws $ExitedByUser when environment has no terminal',
          () async {
            when(
              gitDir.isWorkingTreeClean,
            ).thenAnswer((_) => Future.value(false));
            when(() => stdInWrapper.hasTerminal).thenReturn(true);
            when(
              () => logger.chooseOne(
                'Would you like to proceed anyways?',
                choices: ['no', 'yes'],
                defaultValue: 'no',
              ),
            ).thenReturn('no');

            expect(
              command.checkIfWorkingTreeIsClean(gitDir),
              throwsA(const TypeMatcher<ExitedByUser>()),
            );
          },
        );
      },
    );

    group('gitProviderSha', () {
      late PublishCommand command;
      setUp(() {
        gitDir = MockGitDir();
        ciWrapper = MockCiWrapper();
        command = PublishCommand(
          logger: logger,
          ciWrapper: ciWrapper,
        )..testArgResults = argResults;
      });

      final commits = Commit.parseRawRevList('''
commit 0be60db261a03a8f52682c08059f64aee7f95266
tree 267fb23ff1f1068036daa3b22d718bd60f13fe58
parent 38b0f7a07a6167d8ea3784bfbe3daed621d3d06a
author Jens Horstmann <jens@widgetbook.io> 1629798144 +0200
committer Jens Horstmann <jens@widgetbook.io> 1629798144 +0200
gpgsig -----BEGIN PGP SIGNATURE-----
 
 iQIzBAABCAAdFiEEreLD3+J+h9tJRnIoeg4vq5dWIsAFAmEkvwAACgkQeg4vq5dW
 IsAr4A//Q5X1Eapxz9YTDHC9/S9IdbfcUHek80L+7sgMIG0dLHcR+TLqBiiuHT06
 qWLvYjER+dDruGGs8+7umqKpeudj45/FlwBSZrnjhZT1Ne1p5DjfL6HnSTzZfODr
 ddrGO7KhOqRYb2kmeZFl9CdpYXRXCwsyIH1kOJpBa/rzZHy2IIzFThqAxmf0SCi6
 WRNfkTe0dHYfwqJ9GLsKm+iJDi814xUn4oLjiL5+AbyfhMnIBNqgwU05jhLRIRAz
 FCnrA4LBeo0LyEDWwLYaH+wIkmrcvNgWwrpx+sHa5L3IgLKtYk4Q041VIbQE6RQC
 6d43kC5mtbaiGOFMQ8Medw7UmebPvSgSJgPINvXJv4FoH8X2D1jbH7ILQFyHoQ6G
 ng1T6QRioNtPWwSoJrZMhJ1PL8UYgLs54KiqfSGcyRJeYXrzhUzH+FV1g+GNWNzN
 MQZkYRHGeBPgjxArIBQ5PMbrFQ509wJPkvstD1F2dUhvoAJn8dvIxgW7yQ0+QR0E
 qjfr7IrWTa67N42YW+hp0F03JcFO4WR6KiWJ8di0s+80f8IsJzEHVX931uQPPHdv
 UYIWXp6dHxI8dE/8ig9GJWpz5lR9YNL+E19y6sqkOGxsx4jcYJ0aPNG2Wnq4328q
 DZpzQwA3HzkANdX96ZhaFse73cHwpFgu+SK/8UjCNxEoDR+lzIQ=
 =dlq9
 -----END PGP SIGNATURE-----

    Merge 8c2d7c9020ffdf6e472114c280e33d022acdd0aa into aa79e17758855284bbf37e784a4a3828b89e27c0

commit 38b0f7a07a6167d8ea3784bfbe3daed621d3d06a
tree da1e88aa7b662db17d7516da4fd8680c88202f53
author Jens Horstmann <jens@widgetbook.io> 1629797227 +0200
committer Jens Horstmann <jens@widgetbook.io> 1629797227 +0200
gpgsig -----BEGIN PGP SIGNATURE-----
 
 iQIzBAABCAAdFiEEreLD3+J+h9tJRnIoeg4vq5dWIsAFAmEku2sACgkQeg4vq5dW
 IsCzIg/+MzhMs+wgkgC8aRjYD+jOIH9bK+3sm1ELKTsb7KSjlc7bKkUWjpo/hrdZ
 qD6twDkWlRr9xPDGegaqAI184KdEvv1vOliU2nR55FipmKEp0mMTx8ayLaX/nBNN
 dTWsUvP9rsEw4PbP2kIWEFFn98uu9WedkP41730Hc4PawAKCLHAUCbee6DjWsLzq
 D6pppPYI0m9q4brFWFzxp9jpTFE4JJMDiq88vSkeTSsYZ64OnpZGwP9gyh0Q+pkc
 pchgB9PwyX0TdyiAiZKTUtCzs8GiNTJIa9l0gERjvtpWu0UTSBawDy1zDXbyDm0x
 oghCKRq58CGbqf9ztpnYuYW7TOguIwNZp5Er9nHv/sV2lYV0Y4CZoy6Dq+QmJIIq
 yV7jHoRKpSATxbCHM4p5rF+jZqrsuX2I0aSGqpRS2b8TQVncT17LXpj4pqyct9rd
 IZ8XQIgcu+4aZdvNDyruEKI6J4pnKlyiqfMa90xUcC5NXT6uNbjrrTfoWRTxyVGW
 Bq4lA1rQ0NNAG/bNWYOLpxOUt8/+GChsJI7b9JcELjvv5BzTpyfqllo5yAF3c54r
 JmrEJIqFL5pvPCGyn2v52W7AZSAszDchnQ2Qu9fr3n9exmkTBWaS+utYbdbPgkQN
 E/2uzTTGrfZw/6jlzj17hQbfKTAdUJhWBqhuP8DTdmOgxQmJGZQ=
 =lDxu
 -----END PGP SIGNATURE-----

    a commit
''');

      test(
        'returns null when not running on GitHub',
        () async {
          when(() => gitDir.commits()).thenAnswer(
            (_) => Future.value({}),
          );
          when(() => ciWrapper.isGithub()).thenReturn(false);
          expect(
            await command.gitProviderSha(gitDir: gitDir),
            isNull,
          );
        },
      );

      test(
        'returns null when not running on PR',
        () async {
          when(() => gitDir.commits()).thenAnswer(
            (_) => Future.value({
              commits.entries.first.key: commits.entries.first.value,
            }),
          );
          when(() => ciWrapper.isGithub()).thenReturn(false);
          expect(
            await command.gitProviderSha(gitDir: gitDir),
            isNull,
          );
        },
      );

      test(
        'returns SHA of second commit when running on PR',
        () async {
          when(() => gitDir.commits()).thenAnswer(
            (_) => Future.value(commits),
          );
          when(() => ciWrapper.isGithub()).thenReturn(true);
          expect(
            await command.gitProviderSha(gitDir: gitDir),
            commits.entries.last.key,
          );
        },
      );
    });

    group('getArguments', () {
      late PublishCommand command;
      late CiParserRunner ciParserRunner;
      late CiParser ciParser;
      setUp(() {
        gitDir = MockGitDir();
        ciParser = MockCiParser();
        ciParserRunner = MockCiParserRunner();
        command = PublishCommand(
          logger: logger,
          ciParserRunner: ciParserRunner,
          stdInWrapper: stdInWrapper,
        )..testArgResults = argResults;
      });

      const expectedArgs = ciArgs;

      group('FromCi (submethod)', () {
        test('returns $CiArgs', () async {
          when(() => ciParserRunner.getParser()).thenReturn(ciParser);
          when(() => ciParser.getCiArgs()).thenAnswer(
            (_) => Future.value(expectedArgs),
          );
          expect(
            await command.getArgumentsFromCi(gitDir),
            equals(expectedArgs),
          );
        });

        test('throws $CiVendorNotSupported', () {
          when(() => ciParserRunner.getParser()).thenReturn(null);
          expect(
            command.getArgumentsFromCi(gitDir),
            throwsA(const TypeMatcher<CiVendorNotSupported>()),
          );
        });
      });

      group('(main method)', () {
        late GitDir gitDir;
        setUp(
          () {
            gitDir = MockGitDir();

            when(() => argResults['path'] as String).thenReturn(path);
            when(() => argResults['api-key'] as String).thenReturn(apiKey);
            when(() => argResults['commit'] as String).thenReturn(commit);
            when(() => argResults['git-provider'] as String)
                .thenReturn(gitProvider);

            // Setup mocks for getArgumentsFromCi
            when(() => ciParserRunner.getParser()).thenReturn(ciParser);
            when(() => ciParser.getCiArgs()).thenAnswer(
              (_) => Future.value(expectedArgs),
            );
          },
        );

        test(
          'returns $PublishArgs when branch from $ArgResults has value',
          () async {
            when(gitDir.currentBranch).thenAnswer(
              (_) => Future.value(branchReference),
            );
            when(() => argResults['branch'] as String).thenReturn(branch);
            expect(
              await command.getArguments(gitDir: gitDir),
              equals(
                PublishArgs(
                  path: path,
                  apiKey: apiKey,
                  branch: branch,
                  commit: commit,
                  gitProvider: gitProvider,
                  vendor: vendor,
                  actor: actor,
                  repository: repository,
                ),
              ),
            );
          },
        );

        test(
          'returns $PublishArgs when branch from $ArgResults is null',
          () async {
            when(gitDir.currentBranch).thenAnswer(
              (_) => Future.value(branchReference),
            );
            when(() => argResults['branch'] as String?).thenReturn(null);
            expect(
              await command.getArguments(gitDir: gitDir),
              equals(
                PublishArgs(
                  path: path,
                  apiKey: apiKey,
                  branch: branchReference.reference,
                  commit: commit,
                  gitProvider: gitProvider,
                  vendor: vendor,
                  actor: actor,
                  repository: repository,
                ),
              ),
            );
          },
        );

        test(
          'throws $ActorNotFoundException when actor is null',
          () async {
            const expectedArguments = CiArgs(vendor: vendor);
            when(gitDir.currentBranch).thenAnswer(
              (_) => Future.value(branchReference),
            );
            when(() => ciParser.getCiArgs()).thenAnswer(
              (_) => Future.value(expectedArguments),
            );
            expect(
              () => command.getArguments(gitDir: gitDir),
              throwsA(const TypeMatcher<ActorNotFoundException>()),
            );
          },
        );

        test(
          'throws $RepositoryNotFoundException when actor is null',
          () async {
            const expectedArguments = CiArgs(vendor: vendor, actor: actor);
            when(gitDir.currentBranch).thenAnswer(
              (_) => Future.value(branchReference),
            );
            when(() => ciParser.getCiArgs()).thenAnswer(
              (_) => Future.value(expectedArguments),
            );
            expect(
              () => command.getArguments(gitDir: gitDir),
              throwsA(const TypeMatcher<RepositoryNotFoundException>()),
            );
          },
        );
      });
    });

    test(
        'throws a $CiVendorNotSupported when CI/CD pipeline '
        'provider is currently not supported', () async {
      final publishCommand = PublishCommand(
        logger: logger,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          gitDir: gitDir,
          ciWrapper: ciWrapper,
        ),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);
      when(() => ciWrapper.isCI()).thenReturn(true);
      when(() => ciWrapper.isGithub()).thenReturn(false);
      when(() => ciWrapper.isBitBucket()).thenReturn(false);
      when(() => ciWrapper.isGitLab()).thenReturn(false);
      when(() => ciWrapper.isAzure()).thenReturn(false);

      expect(
        publishCommand.run,
        throwsA(const TypeMatcher<CiVendorNotSupported>()),
      );
    });

    test(
        'throws a $ExitedByUser when user decides not to '
        'proceed with un-commited changes', () async {
      final publishCommand = PublishCommand(
        logger: logger,
        stdInWrapper: stdInWrapper,
        ciParserRunner: CiParserRunner(argResults: argResults, gitDir: gitDir),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);
      when(() => gitDir.getActorName())
          .thenAnswer((_) => Future.value('John Doe'));
      when(() => stdInWrapper.hasTerminal).thenReturn(true);
      when(
        () => logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        ),
      ).thenReturn('no');

      when(() => gitDir.getRepositoryName())
          .thenAnswer((_) => Future.value('widgetbook'));
      expect(
        publishCommand.run,
        throwsA(
          const TypeMatcher<ExitedByUser>(),
        ),
      );
    });

    test(
      'throws $DirectoryNotFoundException when web folder is not found',
      () {
        final fileSystem = MemoryFileSystem.test();

        expect(
          () => publishCommand.getZipFile(fileSystem.directory('/web')),
          throwsA(const TypeMatcher<DirectoryNotFoundException>()),
        );
      },
    );

    test(
      'throws $UnableToCreateZipFileException when zip file could '
      'not be create for upload',
      () {
        when(() => gitDir.allBranches()).thenAnswer((_) => Future.value([]));
        when(() => gitDir.fetch()).thenAnswer(
          (_) => Future.value(),
        );

        final command = PublishCommand(
          logger: logger,
          widgetbookHttpClient: widgetbookHttpClient,
        )..testArgResults = argResults;

        expect(
          () => command.publishBuilds(
            args: TestData.args,
            gitDir: gitDir,
            getZipFile: (fileSystem) => null,
          ),
          throwsA(const TypeMatcher<UnableToCreateZipFileException>()),
        );
      },
    );

    test(
      'throws $WidgetbookDeployException when '
      '[$WidgetbookHttpClient.uploadDeployment] encounters an $Exception',
      () {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

        when(
          () => widgetbookHttpClient.uploadBuild(
            deploymentFile: any(
              named: 'deploymentFile',
            ),
            data: any(
              named: 'data',
            ),
          ),
        ).thenThrow(WidgetbookDeployException(message: 'Dio Error'));
        expect(
          () => publishCommand.uploadDeploymentInfo(
            file: file,
            args: TestData.args,
            themes: [],
            locales: [],
            devices: [],
            textScaleFactors: [],
          ),
          throwsA(const TypeMatcher<WidgetbookDeployException>()),
        );
      },
    );

    test(
      'throws $WidgetbookPublishReviewException when '
      '[$WidgetbookHttpClient.uploadReview] encounters an $Exception',
      () {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

        when(
          () => widgetbookHttpClient.uploadReview(
            apiKey: any(
              named: 'apiKey',
            ),
            useCases: any(
              named: 'useCases',
            ),
            buildId: any(
              named: 'buildId',
            ),
            projectId: any(
              named: 'projectId',
            ),
            baseBranch: any(
              named: 'baseBranch',
            ),
            headBranch: any(
              named: 'headBranch',
            ),
            baseSha: any(
              named: 'baseSha',
            ),
            headSha: any(
              named: 'headSha',
            ),
          ),
        ).thenThrow(WidgetbookPublishReviewException(message: 'Dio Error'));
        expect(
          () => publishCommand.uploadReview(
            file: file,
            args: TestData.args,
            reviewData: TestData.reviewData,
          ),
          throwsA(const TypeMatcher<WidgetbookPublishReviewException>()),
        );
      },
    );

    test(
      'uploadDeployment method returns a $Map when '
      '[$WidgetbookHttpClient.uploadDeployment] runs successfully',
      () async {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

        when(
          () => widgetbookHttpClient.uploadBuild(
            deploymentFile: any(
              named: 'deploymentFile',
            ),
            data: any(
              named: 'data',
            ),
          ),
        ).thenAnswer((_) => Future.value(TestData.uploadBuildInfo));

        final results = await publishCommand.uploadDeploymentInfo(
          file: file,
          args: TestData.args,
          themes: [],
          locales: [],
          devices: [],
          textScaleFactors: [],
        );

        expect(
          results,
          isA<Map>(),
        );
      },
    );

    test(
      'delete zip',
      () {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        expect(file.existsSync(), isTrue);
        publishCommand.deleteZip(file);
        expect(file.existsSync(), isFalse);
      },
    );
    test('exits with code 0 when publishing a build succeeds', () async {
      final fileSystem = MemoryFileSystem.test();
      final file = fileSystem.file('web.zip')..createSync();

      final publishCommand = PublishCommand(
        fileSystem: localFileSystem,
        widgetbookHttpClient: widgetbookHttpClient,
        logger: logger,
        themeParser: themeParser,
        localeParser: localeParser,
        deviceParser: deviceParser,
        textScaleFactorsParser: textScaleFactorsParser,
        ciParserRunner: CiParserRunner(argResults: argResults, gitDir: gitDir),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);

      when(() => themeParser.parse())
          .thenAnswer((_) => Future.value(TestData.themes));

      when(() => localeParser.parse())
          .thenAnswer((_) => Future.value(TestData.locales));

      when(() => deviceParser.parse())
          .thenAnswer((_) => Future.value(TestData.devices));

      when(() => textScaleFactorsParser.parse())
          .thenAnswer((_) => Future.value(TestData.testScaleFactors));

      when(() => gitDir.getActorName())
          .thenAnswer((_) => Future.value('John Doe'));

      when(() => localFileSystem.directory(any<String>()))
          .thenAnswer((_) => fileSystem.directory('/'));
      when(
        () => logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        ),
      ).thenReturn('yes');

      when(() => gitDir.getRepositoryName())
          .thenAnswer((_) => Future.value('widgetbook'));

      when(
        () => widgetbookHttpClient.uploadBuild(
          deploymentFile: any(
            named: 'deploymentFile',
          ),
          data: any(
            named: 'data',
          ),
        ),
      ).thenAnswer((_) => Future.value(TestData.uploadBuildInfo));

      when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

      when(() => widgetbookZipEncoder.encode(any())).thenReturn(file);
      final result = await publishCommand.run();
      expect(result, equals(ExitCode.success.code));
    });

    test('exits with code 0 when publishing a review succeeds', () async {
      final fileSystem = MemoryFileSystem.test();
      final file = fileSystem.file('web.zip')..createSync();

      final publishCommand = PublishCommand(
        fileSystem: localFileSystem,
        widgetbookHttpClient: widgetbookHttpClient,
        logger: logger,
        themeParser: themeParser,
        localeParser: localeParser,
        deviceParser: deviceParser,
        textScaleFactorsParser: textScaleFactorsParser,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          gitDir: gitDir,
        ),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);

      when(() => argResults['base-branch'] as String).thenReturn('main');

      when(() => argResults['base-commit'] as String).thenReturn('base-commit');

      when(() => themeParser.parse())
          .thenAnswer((_) => Future.value(TestData.themes));

      when(() => localeParser.parse())
          .thenAnswer((_) => Future.value(TestData.locales));

      when(() => deviceParser.parse())
          .thenAnswer((_) => Future.value(TestData.devices));

      when(() => textScaleFactorsParser.parse())
          .thenAnswer((_) => Future.value(TestData.testScaleFactors));

      when(() => gitDir.getActorName())
          .thenAnswer((_) => Future.value('John Doe'));

      when(() => localFileSystem.directory(any<String>()))
          .thenAnswer((_) => fileSystem.directory('/'));
      when(
        () => logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        ),
      ).thenReturn('yes');

      when(() => gitDir.getRepositoryName())
          .thenAnswer((_) => Future.value('widgetbook'));

      when(
        () => widgetbookHttpClient.uploadBuild(
          deploymentFile: any(
            named: 'deploymentFile',
          ),
          data: any(
            named: 'data',
          ),
        ),
      ).thenAnswer((_) => Future.value(TestData.uploadBuildInfo));

      when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

      when(
        () => widgetbookHttpClient.uploadReview(
          apiKey: any(
            named: 'apiKey',
          ),
          useCases: any(
            named: 'useCases',
          ),
          buildId: any(
            named: 'buildId',
          ),
          projectId: any(
            named: 'projectId',
          ),
          baseBranch: any(
            named: 'baseBranch',
          ),
          headBranch: any(
            named: 'headBranch',
          ),
          baseSha: any(
            named: 'baseSha',
          ),
          headSha: any(
            named: 'headSha',
          ),
        ),
      ).thenAnswer((_) => Future.value());

      when(() => widgetbookZipEncoder.encode(any())).thenReturn(file);

      final result = await publishCommand.run();

      expect(result, equals(ExitCode.success.code));

      verify(
        () => logger.warn('You have un-commited changes'),
      ).called(1);
      verify(
        () => logger.warn(
            'Uploading a new build to Widgetbook Cloud requires a commit SHA. '
            'Due to un-committed changes, we are using the commit SHA '
            'of your previous commit which can lead to the build being '
            'rejected due to an already existing build.'),
      ).called(1);
    });
  });
}
