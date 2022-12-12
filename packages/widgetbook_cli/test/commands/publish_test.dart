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
import '../../bin/models/deployment_data.dart';
import '../../bin/models/review_data.dart';
import '../../bin/review/devices/device_parser.dart';
import '../../bin/review/locales/locales_parser.dart';
import '../../bin/review/text_scale_factors/text_scale_factor_parser.dart';
import '../../bin/review/themes/theme_parser.dart';
import '../../bin/std/stdin_wrapper.dart';
import '../helpers/test_data.dart';
import '../mocks/mocks.dart';

class FakeFile extends Fake implements File {}

class FakeDeploymentData extends Fake implements DeploymentData {}

class FakeReviewData extends Fake implements ReviewData {}

class FakeDirectory extends Fake implements Directory {}

void main() {
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

      when(() => argResults['api-key'] as String).thenReturn('Api-Key');
      when(() => argResults['git-provider'] as String).thenReturn('Local');

      registerFallbackValue(FakeFile());
      registerFallbackValue(FakeDeploymentData());
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
                progress: progress,
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
                progress: progress,
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
                progress: progress,
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
                progress: progress,
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
                  progress: progress,
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
                progress: progress,
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
                progress: progress,
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
                progress: progress,
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
                progress: progress,
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

    test(
        'exits with code 70 when CI/CD pipeline '
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

      final result = await publishCommand.run();
      expect(result, equals(ExitCode.software.code));

      verify(
        () => logger
            .err('Your CI/CD pipeline provider is currently not supported.'),
      ).called(1);
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
      'throws $ActorNotFoundException when actor is not found',
      () {
        expect(
          () => publishCommand.publishBuilds(
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs.copyWith(actor: null),
            gitDir: gitDir,
            publishProgress: publishProgress(),
            getZipFile: (fileSystem) => null,
          ),
          throwsA(const TypeMatcher<ActorNotFoundException>()),
        );
      },
    );

    test(
      'throws $RepositoryNotFoundException when respository is not found',
      () {
        expect(
          () => publishCommand.publishBuilds(
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs.copyWith(repository: null),
            gitDir: gitDir,
            publishProgress: publishProgress(),
            getZipFile: (fileSystem) => null,
          ),
          throwsA(const TypeMatcher<RepositoryNotFoundException>()),
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

        expect(
          () => publishCommand.publishBuilds(
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs,
            gitDir: gitDir,
            publishProgress: publishProgress(),
            getZipFile: (fileSystem) => null,
          ),
          throwsA(const TypeMatcher<UnableToCreateZipFileException>()),
        );

        verify(
          () => publishProgress().update('Getting branches'),
        ).called(1);
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
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs,
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
            themes: any(
              named: 'themes',
            ),
            locales: any(
              named: 'locales',
            ),
            devices: any(
              named: 'devices',
            ),
            textScaleFactors: any(
              named: 'textScaleFactors',
            ),
          ),
        ).thenThrow(WidgetbookPublishReviewException(message: 'Dio Error'));
        expect(
          () => publishCommand.uploadReview(
            file: file,
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs,
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
          cliArgs: TestData.ciArgsData,
          ciArgs: TestData.ciArgs,
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

      verify(
        () => logger.progress(
          'Uploading build',
        ),
      ).called(1);

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
          themes: any(
            named: 'themes',
          ),
          locales: any(
            named: 'locales',
          ),
          devices: any(
            named: 'devices',
          ),
          textScaleFactors: any(
            named: 'textScaleFactors',
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
