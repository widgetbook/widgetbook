part of 'coverage_command.dart';

/// Spawns an isolate to resolve the widgetbook usecases in a flutter project
/// and returns the list of widgets found
Future<List<String>> _getProjectWidgetbookUseCases(
  PathData pathData,
  Logger logger,
) async {
  final progress = logger.progress('Resolving use-cases...');

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
      progress.complete();
      usecases = [...data.result];
      break;
    }

    progress.update(
      'Found ${data.result.length} use-cases',
    );
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
