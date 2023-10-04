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
import '../../bin/git/diff_header.dart';
import '../../bin/git/git_manager.dart';
import '../../bin/git/reference.dart';
import '../../bin/git/repository.dart';
import '../../bin/helpers/helpers.dart';
import '../../bin/models/models.dart';
import '../../bin/review/changed_use_case.dart';
import '../../bin/review/use_case_reader.dart';
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
    late GitManager gitManager;
    late Repository repository;
    late CiWrapper ciWrapper;
    late Platform platform;
    late ArgResults argResults;
    late PublishCommand publishCommand;
    late WidgetbookHttpClient client;
    late LocalFileSystem localFileSystem;
    late UseCaseReader useCaseReader;
    late Progress progress;
    late Stdin stdin;
    final tempDir = const LocalFileSystem().currentDirectory;

    setUp(() async {
      logger = MockLogger();
      gitManager = MockGitWrapper();
      repository = MockRepository();
      argResults = MockArgResults();
      ciWrapper = MockCiWrapper();
      client = MockWidgetbookHttpClient();
      localFileSystem = MockLocalFileSystem();
      useCaseReader = MockUseCaseReader();
      progress = MockProgress();
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
        final branchRefA = Reference(
          '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf',
          'refs/heads/a',
        );
        final branchRefB = Reference(
          'f1c882189d0b341e435a58992c6b78a6a3f5ebfc',
          'refs/heads/b',
        );
        final branchRefC = Reference(
          '20dbdee64ee73e4be43b9c949492e05437d0e5dc',
          'refs/remotes/origin/c',
        );
        final branchRefD = Reference(
          'd4b6472e1566eb2c9897e4fc4d8c4858628bca01',
          'refs/remotes/origin/d',
        );

        setUp(
          () {
            when(
              () => repository.fetch(),
            ).thenAnswer((_) async => true);
          },
        );

        group('without branches', () {
          setUp(() {
            when(() => repository.branches).thenAnswer((_) async => []);
          });

          test(
            "returns null when invoked with 'a'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                repository: repository,
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
                repository: repository,
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
                repository: repository,
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
                repository: repository,
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
              when(() => repository.branches).thenAnswer(
                (_) async => [
                  branchRefC,
                  branchRefD,
                ],
              );
            });

            test(
              "returns 'refs/origin/c' with SHA when invoked "
              "with 'refs/heads/c'",
              () async {
                final branch = await publishCommand.getBaseBranch(
                  repository: repository,
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
            when(() => repository.branches).thenAnswer(
              (_) async => [
                branchRefA,
                branchRefB,
                branchRefC,
                branchRefD,
              ],
            );
          });

          test(
            "returns 'refs/heads/a' with SHA when invoked with 'a'",
            () async {
              final branch = await publishCommand.getBaseBranch(
                repository: repository,
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
                repository: repository,
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
                repository: repository,
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
                repository: repository,
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
      '.promptUncommittedChanges',
      () {
        late PublishCommand command;

        setUp(() {
          command = PublishCommand(
            logger: logger,
          )..testArgResults = argResults;
        });

        test(
          'returns true when environment has no terminal',
          () async {
            when(() => stdin.hasTerminal).thenReturn(false);

            IOOverrides.runZoned(
              stdin: () => stdin,
              () {
                expect(
                  command.promptUncommittedChanges(),
                  true,
                );
              },
            );
          },
        );

        test(
          'returns true when user chooses "yes"',
          () async {
            when(() => stdin.hasTerminal).thenReturn(true);
            when(
              () => logger.chooseOne<String>(
                any(),
                choices: any(named: 'choices'),
                defaultValue: any(named: 'defaultValue'),
              ),
            ).thenReturn('yes');

            IOOverrides.runZoned(
              stdin: () => stdin,
              () {
                expect(
                  command.promptUncommittedChanges(),
                  true,
                );
              },
            );
          },
        );

        test(
          'returns false when user chooses "no"',
          () async {
            when(() => stdin.hasTerminal).thenReturn(true);
            when(
              () => logger.chooseOne<String>(
                any(),
                choices: any(named: 'choices'),
                defaultValue: any(named: 'defaultValue'),
              ),
            ).thenReturn('no');

            IOOverrides.runZoned(
              stdin: () => stdin,
              () {
                expect(
                  command.promptUncommittedChanges(),
                  false,
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
        repository = MockRepository();
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
        repository = MockRepository();
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
            await command.getArgumentsFromCi(repository),
            equals(expectedArgs),
          );
        });

        test('throws $CiVendorNotSupported', () {
          when(() => ciParserRunner.getParser()).thenReturn(null);
          expect(
            command.getArgumentsFromCi(repository),
            throwsA(const TypeMatcher<CiVendorNotSupported>()),
          );
        });
      });

      group('(main method)', () {
        setUp(
          () {
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
            when(() => argResults['branch'] as String).thenReturn(branch);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => branchReference,
            );

            expect(
              await command.getArguments(repository: repository),
              equals(
                const PublishArgs(
                  path: path,
                  apiKey: apiKey,
                  branch: branch,
                  commit: commit,
                  vendor: vendor,
                  actor: actor,
                  repository: repoName,
                ),
              ),
            );
          },
        );

        test(
          'returns $PublishArgs when branch from $ArgResults is null',
          () async {
            when(() => argResults['branch'] as String?).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => branchReference,
            );

            expect(
              await command.getArguments(repository: repository),
              equals(
                PublishArgs(
                  path: path,
                  apiKey: apiKey,
                  branch: branchReference.fullName,
                  commit: commit,
                  vendor: vendor,
                  actor: actor,
                  repository: repoName,
                ),
              ),
            );
          },
        );

        test(
          'throws $ActorNotFoundException when actor is null',
          () async {
            when(() => ciParser.getCiArgs()).thenAnswer(
              (_) async => const CiArgs(vendor: vendor),
            );

            when(() => repository.currentBranch).thenAnswer(
              (_) async => branchReference,
            );

            expect(
              () => command.getArguments(repository: repository),
              throwsA(const TypeMatcher<ActorNotFoundException>()),
            );
          },
        );

        test(
          'throws $RepositoryNotFoundException when actor is null',
          () async {
            when(() => ciParser.getCiArgs()).thenAnswer(
              (_) async => const CiArgs(
                vendor: vendor,
                actor: actor,
              ),
            );

            when(() => repository.currentBranch).thenAnswer(
              (_) async => branchReference,
            );

            expect(
              () => command.getArguments(repository: repository),
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
          repository: repository,
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
        gitManager: gitManager,
        ciParserRunner:
            CiParserRunner(argResults: argResults, repository: repository),
      )..testArgResults = argResults;

      when(() => argResults['path'] as String).thenReturn(tempDir.path);
      when(() => gitManager.load(any())).thenReturn(repository);
      when(() => repository.user).thenAnswer((_) async => 'John Doe');
      when(() => repository.name).thenAnswer((_) async => 'widgetbook');
      when(() => repository.isClean).thenAnswer((_) async => false);
      when(() => stdin.hasTerminal).thenReturn(true);
      when(
        () => logger.chooseOne<String>(
          any(),
          choices: any(named: 'choices'),
          defaultValue: any(named: 'defaultValue'),
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
        when(() => repository.branches).thenAnswer((_) async => []);
        when(() => repository.fetch()).thenAnswer(
          (_) async => true,
        );

        final command = PublishCommand(
          logger: logger,
          client: client,
        )..testArgResults = argResults;

        expect(
          () => command.publish(
            args: TestData.args,
            repository: repository,
          ),
          throwsA(const TypeMatcher<UnableToCreateZipFileException>()),
        );
      },
    );

    test('exits with code 0 when publishing a build succeeds', () async {
      final fileSystem = MemoryFileSystem.test();

      final publishCommand = PublishCommand(
        fileSystem: localFileSystem,
        useCaseReader: useCaseReader,
        client: client,
        logger: logger,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          repository: repository,
        ),
      )..testArgResults = argResults;

      when(() => useCaseReader.read(any())).thenAnswer(
        (_) async => [],
      );

      when(
        () => useCaseReader.compare(
          useCases: any(named: 'useCases'),
          diffs: any(named: 'diffs'),
        ),
      ).thenReturn(const [
        ChangedUseCase(
          name: 'use_case',
          componentName: 'UseCase',
          componentDefinitionPath: 'path/to/use_case.dart',
          modification: Modification.changed,
          designLink: null,
        ),
      ]);

      when(() => argResults['path'] as String).thenReturn(tempDir.path);
      when(() => repository.user).thenAnswer((_) async => 'John Doe');

      when(() => localFileSystem.directory(any<String>())).thenAnswer(
        ($) => fileSystem.directory($.positionalArguments[0])
          ..createSync(
            recursive: true,
          ),
      );

      when(() => localFileSystem.file(any<String>())).thenAnswer(
        ($) => fileSystem.file($.positionalArguments[0])
          ..createSync(
            recursive: true,
          ),
      );

      when(() => repository.name).thenAnswer((_) async => 'widgetbook');
      when(
        () => logger.chooseOne<String>(
          any(),
          choices: any(named: 'choices'),
          defaultValue: any(named: 'defaultValue'),
        ),
      ).thenReturn('yes');

      when(
        () => client.uploadBuild(any<BuildRequest>()),
      ).thenAnswer(
        (_) async => TestData.buildResponse,
      );

      final result = await publishCommand.run();
      expect(result, equals(ExitCode.success.code));
    });

    test('exits with code 0 when publishing a review succeeds', () async {
      final fileSystem = MemoryFileSystem.test();

      final publishCommand = PublishCommand(
        fileSystem: localFileSystem,
        client: client,
        logger: logger,
        useCaseReader: useCaseReader,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          repository: repository,
        ),
      )..testArgResults = argResults;

      when(() => useCaseReader.read(any())).thenAnswer(
        (_) async => [],
      );

      when(
        () => useCaseReader.compare(
          useCases: any(named: 'useCases'),
          diffs: any(named: 'diffs'),
        ),
      ).thenReturn(const [
        ChangedUseCase(
          name: 'use_case',
          componentName: 'UseCase',
          componentDefinitionPath: 'path/to/use_case.dart',
          modification: Modification.changed,
          designLink: null,
        ),
      ]);

      when(() => argResults['path'] as String).thenReturn(tempDir.path);
      when(() => argResults['base-branch'] as String).thenReturn('main');
      when(() => argResults['base-commit'] as String).thenReturn('base-commit');
      when(() => repository.user).thenAnswer((_) async => 'John Doe');
      when(() => repository.name).thenAnswer((_) async => 'widgetbook');

      when(() => localFileSystem.directory(any<String>())).thenAnswer(
        ($) => fileSystem.directory($.positionalArguments[0])
          ..createSync(
            recursive: true,
          ),
      );

      when(() => localFileSystem.file(any<String>())).thenAnswer(
        ($) => fileSystem.file($.positionalArguments[0])
          ..createSync(
            recursive: true,
          ),
      );

      when(
        () => logger.chooseOne<String>(
          any(),
          choices: any(named: 'choices'),
          defaultValue: any(named: 'defaultValue'),
        ),
      ).thenReturn('yes');

      when(
        () => client.uploadBuild(any<BuildRequest>()),
      ).thenAnswer(
        (_) async => TestData.buildResponse,
      );

      when(
        () => client.uploadReview(any<ReviewRequest>()),
      ).thenAnswer(
        (_) async => TestData.reviewResponse,
      );

      final result = await publishCommand.run();

      expect(result, equals(ExitCode.success.code));
    });
  });
}
