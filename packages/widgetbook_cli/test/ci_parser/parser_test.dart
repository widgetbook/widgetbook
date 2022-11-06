import 'package:args/args.dart';
import 'package:test/test.dart';

import '../../bin/ci_parser/parser.dart';
import '../mocks/command_mocks.dart';

const vendorName = 'TestVendor';
const repositoryName = 'widgetbook';
const actorName = 'John Doe';

class TestCiParser extends CiParser {
  TestCiParser({
    required super.argResults,
  });
  @override
  Future<String?> getActor() {
    return Future.value(actorName);
  }

  @override
  Future<String?> getRepository() {
    return Future.value(repositoryName);
  }

  @override
  String get vendor => vendorName;
}

void main() {
  late TestCiParser sut;
  late ArgResults argResults;

  setUp(() {
    argResults = MockArgResults();
    sut = TestCiParser(argResults: argResults);
  });

  group('$CiParser', () {
    test(
      'expect instance of $ArgResults',
      () async {
        expect(sut.argResults, equals(argResults));
      },
    );

    test(
      'can get a vendor',
      () async {
        expect(sut.vendor, equals(vendorName));
      },
    );

    test(
      'can get a Repository',
      () async {
        final repository = await sut.getRepository();
        expect(repository, equals(repositoryName));
      },
    );
    test(
      'can get an Actor',
      () async {
        final actor = await sut.getActor();
        expect(actor, equals(actorName));
      },
    );
  });
}
