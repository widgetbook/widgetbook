import 'package:mason_logger/mason_logger.dart';

/// The exit codes of `widgetbook test`, one per failure it can name.
/// A failing scenario exits with the code of `flutter test` itself.
abstract final class TestExitCodes {
  /// A `--path` matches no file.
  static final pathNotFound = ExitCode.noInput.code;

  /// A `--path` file declares no Widgetbook component.
  static final noComponent = ExitCode.data.code;

  /// The project's `widgetbook` version does not support a flag.
  static final unsupportedVersion = ExitCode.unavailable.code;

  /// `build_runner build` failed.
  static final buildRunnerFailed = ExitCode.software.code;

  /// The selection matched no test; `flutter test` exits with the same code.
  static const noTestsRan = 79;

  /// Every matched scenario is excluded via `excludeFromTests`.
  static final allSkipped = ExitCode.tempFail.code;
}
