import 'dart:io';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform/platform.dart';
import 'package:test/test.dart';

import '../../bin/api/api.dart';
import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/commands/commands.dart';
import '../../bin/git/branch_reference.dart';
import '../../bin/git/git_dir.dart';
import '../../bin/git/git_wrapper.dart';
import '../../bin/git/modification.dart';
import '../../bin/helpers/helpers.dart';
import '../../bin/models/models.dart';
import '../../bin/review/use_cases/changed_use_case.dart';
import '../../bin/review/use_cases/use_case_parser.dart';
import '../helpers/test_data.dart';
import '../mocks/mocks.dart';
import '../mocks/models/models.dart';

class FakeFile extends Fake implements File {}

class FakeBuildRequest extends Fake implements BuildRequest {}

class FakeReviewRequest extends Fake implements ReviewRequest {}

class FakeDirectory extends Fake implements Directory {}

void main() {
  const apiKey = 'Api-Key';
  const path = 'path';
  const branch = 'branch';
  const commit = 'commit';

  group('$PublishCommand', () {
    late Logger logger;
    late GitWrapper gitWrapper;
    late GitDir gitDir;
    late CiWrapper ciWrapper;
    late Platform platform;
    late ArgResults argResults;
    late PublishCommand publishCommand;
    late WidgetbookHttpClient client;
    late WidgetbookZipEncoder widgetbookZipEncoder;
    late LocalFileSystem localFileSystem;
    late Progress progress;
    late UseCaseParser useCaseParser;
    late Stdin stdin;
    final tempDir = const LocalFileSystem().currentDirectory;

    setUp(() async {
      logger = MockLogger();
      gitWrapper = MockGitWrapper();
      gitDir = MockGitDir();
      argResults = MockArgResults();
      ciWrapper = MockCiWrapper();
      client = MockWidgetbookHttpClient();
      widgetbookZipEncoder = MockWidgetbookZipEncoder();
      localFileSystem = MockLocalFileSystem();
      progress = MockProgress();
      useCaseParser = MockUseCaseParser();
      stdin = MockStdin();

      when(() => logger.progress(any<String>())).thenReturn(progress);
      publishCommand = PublishCommand(
        logger: logger,
        client: client,
      )..testArgResults = argResults;

      when(() => argResults['api-key'] as String).thenReturn(apiKey);

      registerFallbackValue(FakeFile());
      registerFallbackValue(FakeBuildRequest());
      registerFallbackValue(FakeReviewRequest());
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
            when(() => stdin.hasTerminal).thenReturn(false);

            IOOverrides.runZoned(
              stdin: () => stdin,
              () {
                expect(
                  command.checkIfWorkingTreeIsClean(gitDir),
                  completes,
                );
              },
            );
          },
        );

        test(
          'throws $ExitedByUser when environment has no terminal',
          () async {
            when(
              gitDir.isWorkingTreeClean,
            ).thenAnswer((_) => Future.value(false));
            when(() => stdin.hasTerminal).thenReturn(true);

            when(
              () => logger.chooseOne(
                'Would you like to proceed anyways?',
                choices: ['no', 'yes'],
                defaultValue: 'no',
              ),
            ).thenReturn('no');

            IOOverrides.runZoned(
              stdin: () => stdin,
              () {
                expect(
                  command.checkIfWorkingTreeIsClean(gitDir),
                  throwsA(const TypeMatcher<ExitedByUser>()),
                );
              },
            );
          },
        );
      },
    );

    group('gitProviderSha', () {
      late PublishCommand command;
      const commitSha = '0be60db261a03a8f52682c08059f64aee7f95266';

      setUp(() {
        gitDir = MockGitDir();
        ciWrapper = MockCiWrapper();
        platform = MockPlatform();
        command = PublishCommand(
          logger: logger,
          ciWrapper: ciWrapper,
          platform: platform,
        )..testArgResults = argResults;
      });

      test(
        'returns null when not running on CI',
        () async {
          when(() => ciWrapper.isGithub()).thenReturn(false);
          when(() => ciWrapper.isCodemagic()).thenReturn(false);
          expect(
            command.gitProviderSha(),
            isNull,
          );
        },
      );

      test(
        'returns SHA of second commit when running on GitHub',
        () async {
          when(() => ciWrapper.isGithub()).thenReturn(true);
          when(() => ciWrapper.isCodemagic()).thenReturn(false);
          when(
            () => platform.environment,
          ).thenReturn({
            'GITHUB_SHA': commitSha,
          });

          expect(
            command.gitProviderSha(),
            commitSha,
          );
        },
      );

      test(
        'returns null when not running on Codemagic',
        () async {
          when(() => ciWrapper.isGithub()).thenReturn(false);
          when(() => ciWrapper.isCodemagic()).thenReturn(true);
          when(
            () => platform.environment,
          ).thenReturn({
            'CM_COMMIT': commitSha,
          });

          expect(
            command.gitProviderSha(),
            commitSha,
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
                const PublishArgs(
                  path: path,
                  apiKey: apiKey,
                  branch: branch,
                  commit: commit,
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
      when(() => ciWrapper.isCodemagic()).thenReturn(false);

      expect(
        publishCommand.run,
        throwsA(const TypeMatcher<CiVendorNotSupported>()),
      );
    });

    test(
        'throws a $ExitedByUser when user decides not to '
        'proceed with un-committed changes', () async {
      final publishCommand = PublishCommand(
        logger: logger,
        gitWrapper: gitWrapper,
        ciParserRunner: CiParserRunner(argResults: argResults, gitDir: gitDir),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);

      when(() => gitWrapper.isGitDir(any())).thenAnswer(
        (_) => Future.value(true),
      );

      when(
        () => gitWrapper.fromExisting(
          any(),
          allowSubdirectory: true,
        ),
      ).thenAnswer(
        (_) => Future.value(gitDir),
      );

      when(() => gitDir.getActorName()).thenAnswer(
        (_) => Future.value('John Doe'),
      );

      when(() => gitDir.getRepositoryName()).thenAnswer(
        (_) => Future.value('widgetbook'),
      );

      when(() => gitDir.isWorkingTreeClean()).thenAnswer(
        (_) => Future.value(false),
      );

      when(() => stdin.hasTerminal).thenReturn(true);

      when(
        () => logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        ),
      ).thenReturn('no');

      IOOverrides.runZoned(
        stdin: () => stdin,
        () => expect(
          publishCommand.run,
          throwsA(
            const TypeMatcher<ExitedByUser>(),
          ),
        ),
      );
    });

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
          client: client,
        )..testArgResults = argResults;

        expect(
          () => command.publish(TestData.args),
          throwsA(const TypeMatcher<UnableToCreateZipFileException>()),
        );
      },
    );

    test('exits with code 0 when publishing a build succeeds', () async {
      final fileSystem = MemoryFileSystem.test();
      final file = fileSystem.file('web.zip')..createSync();

      final publishCommand = PublishCommand(
        fileSystem: localFileSystem,
        client: client,
        logger: logger,
        useCaseParser: useCaseParser,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          gitDir: gitDir,
        ),
      )..testArgResults = argResults;

      when(() => useCaseParser.parse()).thenAnswer(
        (_) => Future.value(const [
          ChangedUseCase(
            name: 'use_case',
            componentName: 'UseCase',
            componentDefinitionPath: 'path/to/use_case.dart',
            modification: Modification.changed,
            designLink: null,
          ),
        ]),
      );

      when(() => argResults['path'] as String).thenReturn(tempDir.path);

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
        () => client.uploadBuild(any<BuildRequest>()),
      ).thenAnswer(
        (_) async => TestData.buildResponse,
      );

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
        client: client,
        logger: logger,
        useCaseParser: useCaseParser,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          gitDir: gitDir,
        ),
      )..testArgResults = argResults;

      when(() => useCaseParser.parse()).thenAnswer(
        (_) => Future.value(const [
          ChangedUseCase(
            name: 'use_case',
            componentName: 'UseCase',
            componentDefinitionPath: 'path/to/use_case.dart',
            modification: Modification.changed,
            designLink: null,
          ),
        ]),
      );

      when(() => argResults['path'] as String).thenReturn(tempDir.path);

      when(() => argResults['base-branch'] as String).thenReturn('main');

      when(() => argResults['base-commit'] as String).thenReturn('base-commit');

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
        () => client.uploadBuild(any<BuildRequest>()),
      ).thenAnswer(
        (_) async => TestData.buildResponse,
      );

      when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

      when(
        () => client.uploadReview(any<ReviewRequest>()),
      ).thenAnswer(
        (_) async => TestData.reviewResponse,
      );

      when(() => widgetbookZipEncoder.encode(any())).thenReturn(file);

      final result = await publishCommand.run();

      expect(result, equals(ExitCode.success.code));
    });
  });
}
