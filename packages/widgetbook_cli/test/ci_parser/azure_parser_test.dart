import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../mocks/command_mocks.dart';

const repositoryName = 'widgetbook';
const actorName = 'John Doe';

const repositoryEnvVariable = 'Build.Repository.Name';
const actorEnvVariable = 'Agent.Name';

void main() {
  late AzureParser sut;
  late ArgResults argResults;
  late PlatformWrapper platformWrapper;

  setUp(() async {
    argResults = MockArgResults();
    platformWrapper = MockPlatformWrapper();

    sut = AzureParser(
      argResults: argResults,
      platformWrapper: platformWrapper,
    );
  });

  group('$AzureParser', () {
    test(
      'expect instance of $ArgResults',
      () async {
        expect(sut.argResults, equals(argResults));
      },
    );
    test(
      'expect instance of $PlatformWrapper',
      () async {
        expect(sut.platformWrapper, equals(platformWrapper));
      },
    );

    test(
      'returns a vendor',
      () async {
        expect(sut.vendor, equals('Azure'));
      },
    );

    test(
      'can get a repository',
      () async {
        when(
          () => platformWrapper.environmentVariable(
            variable: repositoryEnvVariable,
          ),
        ).thenReturn(repositoryName);

        final repository = await sut.getRepository();
        expect(repository, equals(repositoryName));
      },
    );
    test(
      'can get an actor',
      () async {
        when(
          () => platformWrapper.environmentVariable(
            variable: actorEnvVariable,
          ),
        ).thenReturn(actorName);

        final actor = await sut.getActor();
        expect(actor, equals(actorName));
      },
    );
  });
}
