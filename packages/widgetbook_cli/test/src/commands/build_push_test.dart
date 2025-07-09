import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

import '../../helper/mocks.dart';

void main() {
  group('$BuildPushCommand', () {
    late Logger logger;
    late Repository repository;
    late Progress progress;
    late Context context;

    setUp(() async {
      logger = MockLogger();
      repository = MockRepository();
      progress = MockProgress();
      context = MockContext();

      when(() => logger.progress(any<String>())).thenReturn(progress);

      when(() => context.repository).thenReturn(repository);
    });

    group('parseResults', () {
      late ArgResults results;
      late BuildPushCommand command;

      setUp(() {
        results = MockArgResults();
        command = BuildPushCommand(
          context: context,
        );

        // Default ArgResults
        when(() => results['path']).thenReturn('default path');
        when(() => results['api-key']).thenReturn('default key');
        when(() => results['no-turbo']).thenReturn(true);

        // Default Context
        when(() => context.name).thenReturn('default');
        when(() => context.user).thenReturn('default user');
        when(() => context.project).thenReturn('default repo');
        when(() => context.providerSha).thenReturn('default sha');
        when(() => context.repository).thenReturn(repository);

        // Default Repository
        when(() => repository.currentBranch).thenAnswer(
          (_) async => const Reference(
            'default sha',
            'refs/default/branch',
          ),
        );
      });

      test('path', () async {
        const path = 'root/path/to/project';
        when(() => results['path']).thenReturn(path);

        final args = await command.parseResults(context, results);

        expect(args.path, equals(path));
      });

      test('apiKey', () async {
        const apiKey = 'SeCrEtKeY';
        when(() => results['api-key']).thenReturn(apiKey);

        final args = await command.parseResults(context, results);

        expect(args.apiKey, equals(apiKey));
      });

      group('actor', () {
        test('from $ArgResults', () async {
          const userName = 'John Doe';
          when(() => results['actor']).thenReturn(userName);

          final args = await command.parseResults(context, results);

          expect(args.actor, equals(userName));
        });

        test('from $Context', () async {
          const userName = 'John Doe';
          when(() => results['actor']).thenReturn(null);
          when(() => context.user).thenReturn(userName);

          final args = await command.parseResults(context, results);

          expect(args.actor, equals(userName));
        });

        test('throws $MissingOptionException', () async {
          when(() => results['actor']).thenReturn(null);
          when(() => context.user).thenReturn(null);

          expectLater(
            () => command.parseResults(context, results),
            throwsA(
              isA<MissingOptionException>().having(
                (e) => e.option,
                'option',
                equals('actor'),
              ),
            ),
          );
        });
      });

      group('repository', () {
        test('from $ArgResults', () async {
          const repoName = 'widgetbook';
          when(() => results['repository']).thenReturn(repoName);

          final args = await command.parseResults(context, results);

          expect(args.repository, equals(repoName));
        });

        test('from $Context', () async {
          const repoName = 'widgetbook';
          when(() => results['repository']).thenReturn(null);
          when(() => context.project).thenReturn(repoName);

          final args = await command.parseResults(context, results);

          expect(args.repository, equals(repoName));
        });

        test('throws $MissingOptionException', () async {
          when(() => results['repository']).thenReturn(null);
          when(() => context.project).thenReturn(null);

          expectLater(
            () => command.parseResults(context, results),
            throwsA(
              isA<MissingOptionException>().having(
                (e) => e.option,
                'option',
                equals('repository'),
              ),
            ),
          );
        });

        group('branch', () {
          test('from $ArgResults', () async {
            const branch = 'main';
            when(() => results['branch']).thenReturn(branch);

            final args = await command.parseResults(context, results);
            ;

            expect(args.branch, equals(branch));
          });

          test('from $Repository', () async {
            const branch = 'main';
            when(() => results['branch']).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => const Reference(
                '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf',
                'refs/heads/$branch',
              ),
            );

            final args = await command.parseResults(context, results);
            ;

            expect(args.branch, equals(branch));
          });
        });

        group('commit', () {
          test('from $ArgResults', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(commit);

            final args = await command.parseResults(context, results);
            ;

            expect(args.commit, equals(commit));
          });

          test('from $Context', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(null);
            when(() => context.providerSha).thenReturn(commit);

            final args = await command.parseResults(context, results);
            ;

            expect(args.commit, equals(commit));
          });

          test('from $Repository', () async {
            const commit = '98d8ca84d7e311fe09fd5bc1887bc6b2e501f6bf';
            when(() => results['commit']).thenReturn(null);
            when(() => context.providerSha).thenReturn(null);
            when(() => repository.currentBranch).thenAnswer(
              (_) async => const Reference(
                commit,
                'refs/heads/main',
              ),
            );

            final args = await command.parseResults(context, results);
            ;

            expect(args.commit, equals(commit));
          });
        });
      });
    });
  });
}
