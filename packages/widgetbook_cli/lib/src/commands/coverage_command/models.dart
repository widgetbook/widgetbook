part of 'coverage_command.dart';

/// Data object to hold the paths of the files to be analysed
class PathData {
  PathData({
    required this.filePaths,
    required this.projectRootPath,
  });

  final List<String> filePaths;
  final String projectRootPath;
}

/// Typed data object used to send data from the isolate to the main thread
class SenderPortData {
  const SenderPortData({
    this.isFinished = false,
    required this.result,
  });

  final bool isFinished;
  final List<String> result;
}

/// Typed data object used to send data to the isolate from the main thread
/// on the initialisation of the isolate
class InitialIsolateData {
  InitialIsolateData({
    required this.sendPort,
    required this.filePaths,
    required this.projectRootPath,
  });

  final SendPort sendPort;
  final List<String> filePaths;
  final String projectRootPath;
}
