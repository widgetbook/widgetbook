import 'package:mason_logger/mason_logger.dart';

import './command.dart';

class LogoutCommand extends WidgetbookCommand {
  LogoutCommand({
    super.logger,
  });

  @override
  final String description = 'Logout from Widgetbook Cloud';

  @override
  final String name = 'logout';

  @override
  Future<int> run() async {
    return ExitCode.success.code;
  }
}
