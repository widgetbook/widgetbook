import 'dart:io';

import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/api/api.dart';
import '../../bin/commands/commands.dart';
import '../../bin/context/context.dart';
import '../../bin/git/diff_header.dart';
import '../../bin/git/git_manager.dart';
import '../../bin/git/reference.dart';
import '../../bin/git/repository.dart';
import '../../bin/helpers/helpers.dart';
import '../../bin/review/changed_use_case.dart';
import '../../bin/review/use_case_reader.dart';
import '../helpers/test_data.dart';
import '../mocks/mocks.dart';

class FakeFile extends Fake implements File {}

class FakeBuildRequest extends Fake implements BuildRequest {}

class FakeReviewRequest extends Fake implements ReviewRequest {}

class FakeDirectory extends Fake implements Directory {}

void main() {
  const apiKey = 'Api-Key';

  group('$PublishCommand', () {
    late Logger logger;
    late GitManager gitManager;
    late Repository repository;
    late ArgResults argResults;
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
      client = MockWidgetbookHttpClient();
      localFileSystem = MockLocalFileSystem();
      useCaseReader = MockUseCaseReader();
      progress = MockProgress();
      stdin = MockStdin();

      when(() => logger.progress(any<String>())).thenReturn(progress);
      when(() => argResults['api-key'] as String).thenReturn(apiKey);

      registerFallbackValue(FakeFile());
      registerFallbackValue(FakeDirectory());
      registerFallbackValue(FakeBuildRequest());
      registerFallbackValue(FakeReviewRequest());
    });

    test('can be instantiated without any parameters', () {
      expect(PublishCommand.new, returnsNormally);
    });

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

    group('getArguments', () {
      late PublishCommand command;
      late Context context;

      setUp(() {
        command = PublishCommand()..testArgResults = argResults;
        repository = MockRepository();
        context = MockContext();

        // Default ArgResults
        when(() => argResults['path']).thenReturn('default path');
        when(() => argResults['api-key']).thenReturn('default key');
        when(() => argResults['github-token']).thenReturn('default token');
        when(() => argResults['pr']).thenReturn('default pr');

        // Default Context
        when(() => context.name).thenReturn('default');
        when(() => context.userName).thenReturn('default user');
        when(() => context.repoName).thenReturn('default repo');
        when(() => context.providerSha).thenReturn('default sha');

        // Default Repository
        when(repository.fetch).thenAnswer((_) async => true);
        when(() => repository.currentBranch).thenAnswer(
          (_) async => Reference(
            'default sha',
            'refs/default/branch',
          ),
        );
      });

      test('path', () async {
        const path = 'root/path/to/project';
        when(() => argResults['path']).thenReturn(path);

        final args = await command.getArguments(
          context: context,
          repository: repository,
        );

        expect(args.path, equals(path));
      });

      test('apiKey', () async {
        const apiKey = 'SeCrEtKeY';
        when(() => argResults['api-key']).thenReturn(apiKey);

        final args = await command.getArguments(
          context: context,
          repository: repository,
        );

        expect(args.apiKey, equals(apiKey));
      });

      test('gitHubToken', () async {
        const token = 'SeCrEtKeY';
        when(() => argResults['github-token']).thenReturn(token);

        final args = await command.getArguments(
          context: context,
          repository: repository,
        );

        expect(args.gitHubToken, equals(token));
      });

      test('prNumber', () async {
        const prNumber = '21';
        when(() => argResults['pr']).thenReturn(prNumber);

        final args = await command.getArguments(
          context: context,
          repository: repository,
        );

        expect(args.prNumber, equals(prNumber));
      });

      group('actor', () {
        test('from $ArgResults', () async {
          const userName = 'John Doe';
          when(() => argResults['actor']).thenReturn(userName);

          final args = await command.getArguments(
            context: context,
            repository: repository,
          );

          expect(args.actor, equals(userName));
        });

        test('from $Context', () async {
          const userName = 'John Doe';
          when(() => argResults['actor']).thenReturn(null);
          when(() => context.userName).thenReturn(userName);

          final args = await command.getArguments(
            context: context,
            repository: repository,
          );

          expect(args.actor, equals(userName));
        });

        test('throws $ActorNotFoundException', () async {
          when(() => argResults['actor']).thenReturn(null);
          when(() => context.userName).thenReturn(null);

          expectLater(
            () => command.getArguments(
              context: context,
              repository: repository,
            ),
            throwsA(const TypeMatcher<ActorNotFoundException>()),
          );
        });
      });

      group('repository', () {
        test('from $ArgResults', () async {
          const repoName = 'widgetbook';
          when(() => argResults['repository']).thenReturn(repoName);

          final args = await command.getArguments(
            context: context,
            repository: repository,
          );

          expect(args.repository, equals(repoName));
        });

        test('from $Context', () async {
          const repoName = 'widgetbook';
          when(() => argResults['repository']).thenReturn(null);
          when(() => context.repoName).thenReturn(repoName);

          final args = await command.getArguments(
            context: context,
            repository: repository,
          );

          expect(args.repository, equals(repoName));
        });

        test('throws $RepositoryNotFoundException', () async {
          when(() => argResults['repository']).thenReturn(null);
          when(() => context.repoName).thenReturn(null);

          expectLater(
            () => command.getArguments(
              context: context,
              repository: repository,
            ),
            throwsA(const TypeMatcher<RepositoryNotFoundException>()),
          );
        });

        group('branch', () {
          test('from $ArgResults', () async {
            const branch = 'main';
            when(() => argResults['branch']).thenReturn(branch);

            final args = await command.getArguments(
              context: context,
              repository: repository,
            );

            expect(args.branch, equals(branch));
          });

          test('from $Repository', () async {
            const branch = 'main';
            when(() => argResults['branch']).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => Reference(
                '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf',
                'refs/heads/$branch',
              ),
            );

            final args = await command.getArguments(
              context: context,
              repository: repository,
            );

            expect(args.branch, equals(branch));
          });
        });

        group('commit', () {
          test('from $ArgResults', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => argResults['commit']).thenReturn(commit);

            final args = await command.getArguments(
              context: context,
              repository: repository,
            );

            expect(args.commit, equals(commit));
          });

          test('from $Context', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => argResults['commit']).thenReturn(null);
            when(() => context.providerSha).thenReturn(commit);

            final args = await command.getArguments(
              context: context,
              repository: repository,
            );

            expect(args.commit, equals(commit));
          });

          test('from $Repository', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => argResults['commit']).thenReturn(null);
            when(() => context.providerSha).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => Reference(
                commit,
                'refs/heads/main',
              ),
            );

            final args = await command.getArguments(
              context: context,
              repository: repository,
            );

            expect(args.commit, equals(commit));
          });
        });
      });
    });

    test(
        'throws a $ExitedByUser when user decides not to '
        'proceed with un-committed changes', () async {
      final publishCommand = PublishCommand(
        logger: logger,
        gitManager: gitManager,
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
        when(() => repository.fetch()).thenAnswer((_) async => true);

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
