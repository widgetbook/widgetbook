import 'package:mason_logger/mason_logger.dart';

import './command.dart';

class AnalyzeCommand extends WidgetbookCommand {
  AnalyzeCommand({
    super.logger,
  });

  @override
  final String description = 'Extract use-cases';

  @override
  final String name = 'analyze';

  @override
  Future<int> run() async {
    return ExitCode.success.code;
  }
}
