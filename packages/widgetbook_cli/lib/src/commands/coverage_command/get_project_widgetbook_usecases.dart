part of 'coverage_command.dart';

/// Spawns an isolate to resolve the widgetbook usecases in a flutter project
/// and returns the list of widgets found
Future<List<String>> _getProjectWidgetbookUseCases(
  PathData pathData,
  Logger logger,
) async {
  final timerLogger = TimeLogger(logger);

  timerLogger.start('Resolving Widgetbook usecases...');
  final widgetbookReceivePort = ReceivePort();
  final widgetbookIsolateTask = await Isolate.spawn(
    _resolveWidgetbookUsecases,
    InitialIsolateData(
      sendPort: widgetbookReceivePort.sendPort,
      filePaths: pathData.filePaths,
      projectRootPath: pathData.projectRootPath,
    ),
  );

  var usecases = <String>[];
  await for (final data in widgetbookReceivePort) {
    if (data is! SenderPortData) continue;

    if (data.isFinished) {
      widgetbookIsolateTask.kill();
      stdout.write('\r');
      timerLogger
          .stop('Total Widgetbook usecases found: ${data.result.length}');
      usecases = [...data.result];
      break;
    }

    if (data is List<String>) {
      stdout.write(
        '\rWidgetbook usecases found: ${data.result.length}'.padRight(30),
      );
    }
  }

  return usecases;
}

/// Resolves the usecases in a widgetbook project,
/// ran in a separate isolate as it is a heavy operation
Future<void> _resolveWidgetbookUsecases(InitialIsolateData data) async {
  final usecaseVisitor = WidgetbookUsecaseVisitor();

  for (final filePath in data.filePaths) {
    final result = parseFile(
      path: filePath,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    result.unit.visitChildren(usecaseVisitor);

    data.sendPort.send(
      SenderPortData(
        result: usecaseVisitor.usecases,
      ),
    );
  }

  data.sendPort.send(
    SenderPortData(
      isFinished: true,
      result: usecaseVisitor.usecases,
    ),
  );
}
