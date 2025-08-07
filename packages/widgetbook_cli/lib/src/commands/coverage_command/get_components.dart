part of 'coverage_command.dart';

/// Spawns an isolate to resolve the widgetbook usecases in a flutter project
/// and returns the list of widgets found
Future<Set<String>> _getComponents(
  PathData pathData,
  Logger logger,
) async {
  final progress = logger.progress('Resolving components...');

  final widgetbookReceivePort = ReceivePort();
  final widgetbookIsolateTask = await Isolate.spawn(
    _resolveComponents,
    InitialIsolateData(
      sendPort: widgetbookReceivePort.sendPort,
      filePaths: pathData.filePaths,
      projectRootPath: pathData.projectRootPath,
    ),
  );

  var components = <String>{};

  await for (final data in widgetbookReceivePort) {
    if (data is! SenderPortData) continue;

    if (data.isFinished) {
      widgetbookIsolateTask.kill();
      progress.complete();
      components = data.result;
      break;
    }

    progress.update(
      'Found ${data.result.length} components',
    );
  }

  return components;
}

/// Resolves the usecases in a widgetbook project,
/// ran in a separate isolate as it is a heavy operation
Future<void> _resolveComponents(InitialIsolateData data) async {
  final useCaseVisitor = UseCaseVisitor();

  for (final filePath in data.filePaths) {
    final result = parseFile(
      path: filePath,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    result.unit.visitChildren(useCaseVisitor);

    data.sendPort.send(
      SenderPortData(
        result: useCaseVisitor.components,
      ),
    );
  }

  data.sendPort.send(
    SenderPortData(
      isFinished: true,
      result: useCaseVisitor.components,
    ),
  );
}
