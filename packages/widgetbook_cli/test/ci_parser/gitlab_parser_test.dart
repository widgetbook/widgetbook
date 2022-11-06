import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../mocks/command_mocks.dart';

const repositoryName = 'widgetbook';
const actorName = 'John Doe';

const repositoryEnvVariable = 'CI_PROJECT_NAME';
const actorEnvVariable = 'GITLAB_USER_NAME';

void main() {
  late GitLabParser sut;
  late ArgResults argResults;
  late PlatformWrapper platformWrapper;

  setUp(() async {
    argResults = MockArgResults();
    platformWrapper = MockPlatformWrapper();

    sut = GitLabParser(
      argResults: argResults,
      platformWrapper: platformWrapper,
    );
  });

  group('$GitLabParser', () {
    test(
      'expect instance of $ArgResults',
      () async {
        expect(sut.argResults, equals(argResults));
      },
    );

    test(
      'returns a vendor',
      () async {
        expect(sut.vendor, equals('GitLab'));
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
