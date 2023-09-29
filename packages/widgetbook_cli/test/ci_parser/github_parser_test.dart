import 'package:args/args.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform/platform.dart';
import 'package:test/test.dart';

import '../../bin/ci_parser/ci_parser.dart';
import '../mocks/command_mocks.dart';

const repositoryName = 'widgetbook';
const actorName = 'John Doe';

const repositoryEnvVariable = 'GITHUB_REPOSITORY';
const actorEnvVariable = 'GITHUB_ACTOR';

void main() {
  late GitHubParser sut;
  late ArgResults argResults;
  late Platform platform;

  setUp(() async {
    argResults = MockArgResults();
    platform = MockPlatform();

    sut = GitHubParser(
      argResults: argResults,
      platform: platform,
    );
  });

  group('$GitHubParser', () {
    test(
      'expect instance of $ArgResults',
      () async {
        expect(sut.argResults, equals(argResults));
      },
    );

    test(
      'expect instance of $Platform',
      () async {
        expect(sut.platform, equals(platform));
      },
    );

    test(
      'returns a vendor',
      () async {
        expect(sut.vendor, equals('GitHub'));
      },
    );

    test(
      'can get a repository',
      () async {
        when(
          () => platform.environment,
        ).thenReturn({
          repositoryEnvVariable: repositoryName,
        });

        final repository = await sut.getRepository();
        expect(repository, equals(repositoryName));
      },
    );
    test(
      'can get an actor',
      () async {
        when(
          () => platform.environment,
        ).thenReturn({
          actorEnvVariable: actorName,
        });

        final actor = await sut.getActor();
        expect(actor, equals(actorName));
      },
    );
  });
}
