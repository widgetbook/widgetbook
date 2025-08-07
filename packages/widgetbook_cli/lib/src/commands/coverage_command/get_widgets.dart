part of 'coverage_command.dart';

/// Spawns an isolate to resolve the widgets in a flutter project
/// and returns the list of widgets found.
Future<Set<String>> _getWidgets(
  PathData pathData,
  Logger logger,
) async {
  final progress = logger.progress('Resolving widgets');

  final widgetReceivePort = ReceivePort();
  final widgetIsolateTask = await Isolate.spawn(
    _resolveWidgets,
    InitialIsolateData(
      sendPort: widgetReceivePort.sendPort,
      filePaths: pathData.filePaths,
      projectRootPath: pathData.projectRootPath,
    ),
  );

  var widgets = <String>{};

  await for (final data in widgetReceivePort) {
    if (data is! SenderPortData) continue;
    if (data.isFinished) {
      widgets = data.result;
      widgetIsolateTask.kill();
      progress.complete();
      break;
    }

    progress.update('Found ${data.result.length} widgets');
  }

  return widgets;
}

/// Resolves the widgets in a flutter project,
/// run in a seperate isolate as it is a heavy operation
Future<void> _resolveWidgets(InitialIsolateData data) async {
  final widgetVisitor = WidgetVisitor();

  final analyzerContextCollection = AnalysisContextCollection(
    includedPaths: [
      Directory(data.projectRootPath).absolute.path,
    ],
    //TODO: Look into excluding paths
    //excludedPaths
  );

  final analyzerContext = analyzerContextCollection.contextFor(
    Directory(data.projectRootPath).absolute.path,
  );

  final analyzedFilesPath = analyzerContext.contextRoot.analyzedFiles();

  for (final filePath in analyzedFilesPath) {
    final result = await analyzerContext.currentSession.getResolvedUnit(
      filePath,
    );
    if (result is! ResolvedUnitResult) continue;

    result.unit.visitChildren(widgetVisitor);
    data.sendPort.send(
      SenderPortData(
        result: widgetVisitor.widgets,
      ),
    );
  }

  // signals the end of the stream
  analyzerContextCollection.dispose();
  data.sendPort.send(
    SenderPortData(
      isFinished: true,
      result: widgetVisitor.widgets,
    ),
  );
}
