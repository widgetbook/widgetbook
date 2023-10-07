import 'dart:io' hide Directory, File;

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/api/api.dart';
import '../../bin/commands/publish.dart';
import '../../bin/commands/publish_args.dart';
import '../../bin/core/context.dart';
import '../../bin/core/context_manager.dart';
import '../../bin/git/diff_header.dart';
import '../../bin/git/reference.dart';
import '../../bin/git/repository.dart';
import '../../bin/helpers/helpers.dart';
import '../../bin/review/changed_use_case.dart';
import '../../bin/review/use_case_reader.dart';
import '../utils/mocks.dart';

class FakeFile extends Fake implements File {}

class FakeDirectory extends Fake implements Directory {}

class FakeBuildRequest extends Fake implements BuildRequest {}

class FakeReviewRequest extends Fake implements ReviewRequest {}

void main() {
  const buildResponse = BuildResponse(
    project: 'projectId',
    build: 'buildId',
    status: BuildUploadStatus.success,
    tasks: [],
  );

  const reviewResponse = ReviewResponse(
    tasks: [],
    review: Review(
      id: 'reviewId',
    ),
  );

  group('$PublishCommand', () {
    late Logger logger;
    late Repository repository;
    late PublishCommand publishCommand;
    late WidgetbookHttpClient client;
    late FileSystem fileSystem;
    late UseCaseReader useCaseReader;
    late Progress progress;
    late Stdin stdin;
    late ContextManager contextManager;
    late Context localContext;
    late Context globalContext;
    late Directory directory;
    late File file;
    late ZipEncoder zipEncoder;

    setUp(() async {
      logger = MockLogger();
      repository = MockRepository();
      client = MockWidgetbookHttpClient();
      fileSystem = MockFileSystem();
      useCaseReader = MockUseCaseReader();
      progress = MockProgress();
      stdin = MockStdin();
      contextManager = MockContextManager();
      localContext = MockContext();
      globalContext = MockContext();
      directory = MockDirectory();
      file = MockFile();
      zipEncoder = MockZipEncoder();

      when(() => logger.progress(any<String>())).thenReturn(progress);
      publishCommand = PublishCommand(
        context: globalContext,
        logger: logger,
        client: client,
        fileSystem: fileSystem,
        zipEncoder: zipEncoder,
      );

      when(() => contextManager.load(any())).thenAnswer(
        (_) async => localContext,
      );
      when(() => localContext.repository).thenReturn(repository);

      registerFallbackValue(FakeFile());
      registerFallbackValue(FakeBuildRequest());
      registerFallbackValue(FakeReviewRequest());
      registerFallbackValue(FakeDirectory());
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
              );
              expect(branch, equals(branchRefC));
            },
          );
        });
      },
    );
    group(
      'validateRepository',
      () {
        late PublishCommand command;
        late Repository repository;

        setUp(() {
          repository = MockRepository();
          command = PublishCommand(
            context: globalContext,
            logger: logger,
          );
        });

        test(
          'returns true if the repository is clean',
          () async {
            when(() => repository.isClean).thenAnswer((_) async => true);
            when(() => stdin.hasTerminal).thenReturn(true);

            IOOverrides.runZoned(
              stdin: () => stdin,
              () async {
                final result = await command.validateRepository(repository);

                verifyNever(() => logger.warn(any()));
                verifyNever(() => logger.confirm(any()));
                expect(result, true);
              },
            );
          },
        );

        test(
          'returns true when there is no terminal, '
          'even if repository is not clean',
          () async {
            when(() => repository.isClean).thenAnswer((_) async => false);
            when(() => stdin.hasTerminal).thenReturn(false);

            IOOverrides.runZoned(
              stdin: () => stdin,
              () async {
                final result = await command.validateRepository(repository);

                verify(() => logger.warn(any())).called(1);
                expect(result, true);
              },
            );
          },
        );

        test(
          'returns true when user chooses "yes", '
          'even if repository is not clean',
          () async {
            when(() => repository.isClean).thenAnswer((_) async => false);
            when(() => stdin.hasTerminal).thenReturn(true);
            when(() => logger.confirm(any())).thenReturn(true);

            IOOverrides.runZoned(
              stdin: () => stdin,
              () async {
                final result = await command.validateRepository(repository);

                verify(() => logger.warn(any())).called(1);
                expect(result, true);
              },
            );
          },
        );

        test(
          'returns false when user chooses "no"',
          () async {
            when(() => repository.isClean).thenAnswer((_) async => false);
            when(() => stdin.hasTerminal).thenReturn(true);
            when(() => logger.confirm(any())).thenReturn(false);

            IOOverrides.runZoned(
              stdin: () => stdin,
              () async {
                final result = await command.validateRepository(repository);

                verify(() => logger.warn(any())).called(1);
                expect(result, false);
              },
            );
          },
        );
      },
    );

    group('parseResults', () {
      late ArgResults results;
      late PublishCommand command;

      setUp(() {
        results = MockArgResults();
        command = PublishCommand(
          context: globalContext,
        );

        // Default ArgResults
        when(() => results['path']).thenReturn('default path');
        when(() => results['api-key']).thenReturn('default key');
        when(() => results['github-token']).thenReturn('default token');
        when(() => results['pr']).thenReturn('default pr');

        // Default Context
        when(() => localContext.name).thenReturn('default');
        when(() => localContext.user).thenReturn('default user');
        when(() => localContext.project).thenReturn('default repo');
        when(() => localContext.providerSha).thenReturn('default sha');
        when(() => localContext.workingDir).thenReturn('default path');

        // Default Repository
        when(() => repository.currentBranch).thenAnswer(
          (_) async => Reference(
            'default sha',
            'refs/default/branch',
          ),
        );
      });

      test('path', () async {
        const path = 'root/path/to/project';
        when(() => results['path']).thenReturn(path);

        final args = await command.parseResults(localContext, results);

        expect(args.path, equals(path));
      });

      test('apiKey', () async {
        const apiKey = 'SeCrEtKeY';
        when(() => results['api-key']).thenReturn(apiKey);

        final args = await command.parseResults(localContext, results);

        expect(args.apiKey, equals(apiKey));
      });

      test('gitHubToken', () async {
        const token = 'SeCrEtKeY';
        when(() => results['github-token']).thenReturn(token);

        final args = await command.parseResults(localContext, results);

        expect(args.gitHubToken, equals(token));
      });

      test('prNumber', () async {
        const prNumber = '21';
        when(() => results['pr']).thenReturn(prNumber);

        final args = await command.parseResults(localContext, results);

        expect(args.prNumber, equals(prNumber));
      });

      group('actor', () {
        test('from $ArgResults', () async {
          const userName = 'John Doe';
          when(() => results['actor']).thenReturn(userName);

          final args = await command.parseResults(localContext, results);

          expect(args.actor, equals(userName));
        });

        test('from $Context', () async {
          const userName = 'John Doe';
          when(() => results['actor']).thenReturn(null);
          when(() => localContext.user).thenReturn(userName);

          final args = await command.parseResults(localContext, results);

          expect(args.actor, equals(userName));
        });

        test('throws $ActorNotFoundException', () async {
          when(() => results['actor']).thenReturn(null);
          when(() => localContext.user).thenReturn(null);

          expectLater(
            () => command.parseResults(localContext, results),
            throwsA(const TypeMatcher<ActorNotFoundException>()),
          );
        });
      });

      group('repository', () {
        test('from $ArgResults', () async {
          const repoName = 'widgetbook';
          when(() => results['repository']).thenReturn(repoName);

          final args = await command.parseResults(localContext, results);

          expect(args.repository, equals(repoName));
        });

        test('from $Context', () async {
          const repoName = 'widgetbook';
          when(() => results['repository']).thenReturn(null);
          when(() => localContext.project).thenReturn(repoName);

          final args = await command.parseResults(localContext, results);

          expect(args.repository, equals(repoName));
        });

        test('throws $RepositoryNotFoundException', () async {
          when(() => results['repository']).thenReturn(null);
          when(() => localContext.project).thenReturn(null);

          expectLater(
            () => command.parseResults(localContext, results),
            throwsA(const TypeMatcher<RepositoryNotFoundException>()),
          );
        });

        group('branch', () {
          test('from $ArgResults', () async {
            const branch = 'main';
            when(() => results['branch']).thenReturn(branch);

            final args = await command.parseResults(localContext, results);
            ;

            expect(args.branch, equals(branch));
          });

          test('from $Repository', () async {
            const branch = 'main';
            when(() => results['branch']).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => Reference(
                '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf',
                'refs/heads/$branch',
              ),
            );

            final args = await command.parseResults(localContext, results);
            ;

            expect(args.branch, equals(branch));
          });
        });

        group('commit', () {
          test('from $ArgResults', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(commit);

            final args = await command.parseResults(localContext, results);
            ;

            expect(args.commit, equals(commit));
          });

          test('from $Context', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(null);
            when(() => localContext.providerSha).thenReturn(commit);

            final args = await command.parseResults(localContext, results);
            ;

            expect(args.commit, equals(commit));
          });

          test('from $Repository', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(null);
            when(() => localContext.providerSha).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => Reference(
                commit,
                'refs/heads/main',
              ),
            );

            final args = await command.parseResults(localContext, results);
            ;

            expect(args.commit, equals(commit));
          });
        });
      });
    });

    test(
      'throws a $ExitedByUser when user decides not to '
      'proceed with un-committed changes',
      () async {
        final publishCommand = PublishCommand(
          context: globalContext,
          logger: logger,
        );

        when(() => localContext.repository).thenReturn(repository);
        when(() => repository.isClean).thenAnswer((_) async => false);
        when(() => stdin.hasTerminal).thenReturn(true);
        when(() => logger.confirm(any())).thenReturn(false);

        IOOverrides.runZoned(
          stdin: () => stdin,
          () => expect(
            publishCommand.runWith(
              localContext,
              MockPublishArgs(),
            ),
            throwsA(
              const TypeMatcher<ExitedByUser>(),
            ),
          ),
        );
      },
    );

    test(
      'throws $UnableToCreateZipFileException when build dir does not exist',
      () {
        final args = MockPublishArgs();
        final command = PublishCommand(
          context: globalContext,
          fileSystem: fileSystem,
          logger: logger,
        );

        when(() => args.path).thenReturn('path/to/build');
        when(() => directory.existsSync()).thenReturn(false);
        when(
          () => fileSystem.directory(any<String>()),
        ).thenReturn(directory);

        expectLater(
          () => command.publishBuild(args),
          throwsA(const TypeMatcher<UnableToCreateZipFileException>()),
        );
      },
    );

    test(
      'throws $UnableToCreateZipFileException when zip file could '
      'not be create for upload',
      () {
        final args = MockPublishArgs();
        final command = PublishCommand(
          context: globalContext,
          fileSystem: fileSystem,
          logger: logger,
          zipEncoder: zipEncoder,
        );

        when(() => args.path).thenReturn('path/to/build');
        when(() => directory.existsSync()).thenReturn(true);
        when(
          () => fileSystem.directory(any<String>()),
        ).thenReturn(directory);

        when(() => zipEncoder.zip(any())).thenAnswer((_) async => null);

        expectLater(
          () => command.publishBuild(args),
          throwsA(const TypeMatcher<UnableToCreateZipFileException>()),
        );
      },
    );

    test('exits with code 0 when publishing a build succeeds', () async {
      final context = MockContext();
      const args = PublishArgs(
        apiKey: 'apiKey',
        branch: 'feat',
        commit: 'sha',
        path: 'path/to/build/',
        vendor: 'Test',
        actor: 'tester',
        repository: 'widgetbook',
      );

      final command = PublishCommand(
        context: globalContext,
        fileSystem: fileSystem,
        logger: logger,
        client: client,
        zipEncoder: zipEncoder,
      );

      when(() => context.repository).thenAnswer((_) => repository);
      when(() => repository.isClean).thenAnswer((_) async => true);

      when(() => directory.existsSync()).thenReturn(true);
      when(
        () => fileSystem.directory(any<String>()),
      ).thenReturn(directory);

      when(() => zipEncoder.zip(any())).thenAnswer((_) async => file);

      when(
        () => client.uploadBuild(any<BuildRequest>()),
      ).thenAnswer(
        (_) async => buildResponse,
      );

      expect(
        await command.runWith(context, args),
        equals(ExitCode.success.code),
      );
    });

    test('exits with code 0 when publishing a review succeeds', () async {
      final context = MockContext();
      const args = PublishArgs(
        apiKey: 'apiKey',
        branch: 'feat',
        commit: 'sha',
        path: 'path/to/build/',
        vendor: 'Test',
        actor: 'tester',
        repository: 'widgetbook',
        baseBranch: 'main',
      );

      final command = PublishCommand(
        context: globalContext,
        fileSystem: fileSystem,
        logger: logger,
        client: client,
        useCaseReader: useCaseReader,
        zipEncoder: zipEncoder,
      );

      when(() => context.repository).thenAnswer((_) => repository);
      when(() => repository.isClean).thenAnswer((_) async => true);

      when(() => directory.existsSync()).thenReturn(true);
      when(
        () => fileSystem.directory(any<String>()),
      ).thenReturn(directory);

      when(() => zipEncoder.zip(any())).thenAnswer((_) async => file);

      when(
        () => client.uploadBuild(any<BuildRequest>()),
      ).thenAnswer(
        (_) async => buildResponse,
      );

      when(() => repository.diff(any())).thenAnswer((_) async => []);
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

      when(
        () => client.uploadReview(any<ReviewRequest>()),
      ).thenAnswer(
        (_) async => reviewResponse,
      );

      expect(
        await command.runWith(context, args),
        equals(ExitCode.success.code),
      );
    });
  });
}
