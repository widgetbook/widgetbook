import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../mocks/command_mocks.dart';

const repositoryName = 'widgetbook';
const actorName = 'John Doe';

const repositoryEnvVariable = 'BITBUCKET_REPO_FULL_NAME';
const actorEnvVariable = 'BITBUCKET_STEP_TRIGGERER_UUID';

void main() {
  late BitbucketParser sut;
  late ArgResults argResults;
  late PlatformWrapper platformWrapper;

  setUp(() async {
    argResults = MockArgResults();
    platformWrapper = MockPlatformWrapper();

    sut = BitbucketParser(
      argResults: argResults,
      platformWrapper: platformWrapper,
    );
  });

  group('$BitbucketParser', () {
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
        expect(sut.vendor, equals('Bitbucket'));
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
