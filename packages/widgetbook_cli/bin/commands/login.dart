import 'package:mason_logger/mason_logger.dart';

import './command.dart';

class LoginCommand extends WidgetbookCommand {
  LoginCommand({
    super.logger,
  });

  @override
  final String description = 'Login to Widgetbook Cloud';

  @override
  final String name = 'login';

  @override
  Future<int> run() async {
    return ExitCode.success.code;
  }
}
