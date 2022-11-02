import 'dart:io';
import 'widgetbook_command_runner.dart';

void main(List<String> arguments) async {
  await flushThenExit(
    await WidgetbookCommandRunner().run(arguments),
  );
}

/// Flushes the stdout and stderr streams, then exits the program with the given
/// status code.
///
/// This returns a Future that will never complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}
