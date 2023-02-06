import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../mocks/command_mocks.dart';

const repositoryName = 'widgetbook';
const actorName = 'John Doe';

void main() {
  late LocalParser sut;
  late ArgResults argResults;
  late GitDir gitDir;

  setUp(() {
    argResults = MockArgResults();
    gitDir = MockGitDir();
    sut = LocalParser(argResults: argResults, gitDir: gitDir);
  });

  group('$LocalParser', () {
    test(
      'expect instance of $ArgResults',
      () async {
        expect(sut.argResults, equals(argResults));
      },
    );

    test(
      'expect instance of $GitDir',
      () async {
        expect(sut.gitDir, equals(gitDir));
      },
    );

    test(
      'returns a vendor',
      () async {
        expect(sut.vendor, equals('Local'));
      },
    );

    test(
      'can get a repository',
      () async {
        when(() => gitDir.getRepositoryName())
            .thenAnswer((_) => Future.value(repositoryName));

        final repository = await sut.getRepository();
        expect(repository, equals(repositoryName));
      },
    );
    test(
      'can get an actor',
      () async {
        when(() => gitDir.getActorName())
            .thenAnswer((_) => Future.value(actorName));
        final actor = await sut.getActor();
        expect(actor, equals(actorName));
      },
    );
  });
}
