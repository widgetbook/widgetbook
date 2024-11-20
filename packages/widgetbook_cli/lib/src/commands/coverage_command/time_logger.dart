part of 'coverage_command.dart';

class TimeLogger {
  TimeLogger(this.logger);

  final Logger logger;

  final Stopwatch _stopwatch = Stopwatch();

  bool isStopped = false;

  void start(String message) {
    if (_stopwatch.isRunning || isStopped) {
      _stopwatch.reset();
    }

    _stopwatch.start();
    logger.info(message);
    isStopped = false;
  }

  void stop(String message) {
    _stopwatch.stop();

    if (_stopwatch.elapsedMilliseconds > 1000) {
      logger.info(
        '✨ $message (${_stopwatch.elapsed.inSeconds}.${(_stopwatch.elapsedMilliseconds % 1000).toString().padLeft(3, '0')}s)',
      );
    } else {
      logger.info('✨ $message (${_stopwatch.elapsedMilliseconds}ms)');
    }

    isStopped = true;
  }
}
