import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/git/repository.dart';
import '../mocks/command_mocks.dart';

const repositoryName = 'widgetbook';
const actorName = 'John Doe';

void main() {
  late LocalParser sut;
  late ArgResults argResults;
  late Repository repository;

  setUp(() {
    argResults = MockArgResults();
    repository = MockRepository();

    sut = LocalParser(
      argResults: argResults,
      repository: repository,
    );
  });

  group('$LocalParser', () {
    test(
      'expect instance of $ArgResults',
      () async {
        expect(sut.argResults, equals(argResults));
      },
    );

    test(
      'expect instance of $Repository',
      () async {
        expect(sut.repository, equals(repository));
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
        when(() => repository.name).thenAnswer((_) async => repositoryName);

        final name = await sut.getRepository();
        expect(name, equals(repositoryName));
      },
    );
    test(
      'can get an actor',
      () async {
        when(() => repository.user).thenAnswer((_) async => actorName);
        final actor = await sut.getActor();
        expect(actor, equals(actorName));
      },
    );
  });
}
