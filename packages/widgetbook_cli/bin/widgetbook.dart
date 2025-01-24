import 'dart:io';

import 'package:widgetbook_cli/widgetbook_cli.dart';

void main(List<String> args) async {
  const contextManager = ContextManager();
  final repository = await Repository.load(
    Directory.current.path,
  );

  final context = await contextManager.load(
    repository,
  );

  await flushThenExit(
    await CliRunner(
      context: context,
    ).run(args),
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
