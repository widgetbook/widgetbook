import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/git/git_dir.dart';
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
        when(() => gitDir.name).thenAnswer((_) async => repositoryName);

        final repository = await sut.getRepository();
        expect(repository, equals(repositoryName));
      },
    );
    test(
      'can get an actor',
      () async {
        when(() => gitDir.user).thenAnswer((_) async => actorName);
        final actor = await sut.getActor();
        expect(actor, equals(actorName));
      },
    );
  });
}
