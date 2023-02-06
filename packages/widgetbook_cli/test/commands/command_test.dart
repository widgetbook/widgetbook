import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

import '../../bin/commands/command.dart';
import '../mocks/command_mocks.dart';

String commandDescription =
    'Creates a Wrapper for testing Command abstract class';
String commandName = 'Test Command';

class TestCommand extends WidgetbookCommand {
  TestCommand({
    super.logger,
  });

  @override
  String get description => commandDescription;

  @override
  String get name => commandName;
}

void main() {
  late TestCommand sut;
  late Logger logger;
  late ArgResults argResults;

  setUp(() {
    logger = MockLogger();
    argResults = MockArgResults();
    sut = TestCommand(logger: logger)..testArgResults = argResults;
  });

  group('$Command via $WidgetbookCommand', () {
    test('accepts name', () {
      expect(sut.name, equals(commandName));
    });

    test('accepts description', () {
      expect(sut.description, equals(commandDescription));
    });
  });

  group('$WidgetbookCommand', () {
    test('expect instance of logger', () {
      expect(sut.logger, equals(logger));
    });

    test('expect instance of $ArgResults', () {
      expect(sut.testArgResults, equals(argResults));
    });
  });
}
