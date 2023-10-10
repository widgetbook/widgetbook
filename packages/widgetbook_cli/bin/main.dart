import 'dart:io';

import 'package:widgetbook_cli/widgetbook_cli.dart';

void main(List<String> arguments, Environment environment) async {
  const contextManager = ContextManager();
  final context = await contextManager.load(
    Directory.current.path,
    environment,
  );

  await flushThenExit(
    await CliRunner(
      context: context,
    ).run(arguments),
  );
}

/// Flushes the stdout and stderr streams, then exits the program with the given
/// status code.
///
/// This returns a Future that will never complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future<void> flushThenExit(int status) {
  return Future.wait<void>([
    stdout.close(),
    stderr.close(),
  ]).then<void>((_) => exit(status));
}
