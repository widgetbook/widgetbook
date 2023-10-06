import 'dart:io';

import 'package:args/args.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform/platform.dart';
import 'package:process/process.dart';
import 'package:pub_updater/pub_updater.dart';

import '../../bin/api/api.dart';
import '../../bin/context/ci_manager.dart';
import '../../bin/context/context.dart';
import '../../bin/context/context_manager.dart';
import '../../bin/git/git_manager.dart';
import '../../bin/git/repository.dart';
import '../../bin/review/use_case_reader.dart';

class MockLogger extends Mock implements Logger {}

class MockGitManager extends Mock implements GitManager {}

class MockPubUpdater extends Mock implements PubUpdater {}

class MockProgress extends Mock implements Progress {}

class MockArgResults extends Mock implements ArgResults {}

class MockContextManager extends Mock implements ContextManager {}

class MockRepository extends Mock implements Repository {}

class MockContext extends Mock implements Context {}

class MockWidgetbookHttpClient extends Mock implements WidgetbookHttpClient {}

class MockLocalFileSystem extends Mock implements LocalFileSystem {}

class MockCiManager extends Mock implements CiManager {
  void mock({
    bool isCI = true,
    bool isAzure = false,
    bool isBitbucket = false,
    bool isCodemagic = false,
    bool isGitHub = false,
    bool isGitLab = false,
  }) {
    when(() => this.isCI).thenReturn(isCI);
    when(() => this.isAzure).thenReturn(isAzure);
    when(() => this.isBitbucket).thenReturn(isBitbucket);
    when(() => this.isCodemagic).thenReturn(isCodemagic);
    when(() => this.isGitHub).thenReturn(isGitHub);
    when(() => this.isGitLab).thenReturn(isGitLab);
  }
}

class MockPlatform extends Mock implements Platform {}

class MockUseCaseReader extends Mock implements UseCaseReader {}

class MockStdin extends Mock implements Stdin {}

class MockProcessManager extends Mock implements ProcessManager {}

class FakeProcessResult extends Fake implements ProcessResult {}

class MockProcessResult {
  static ProcessResult success(String result) {
    return ProcessResult(
      0,
      0,
      result,
      '',
    );
  }

  static ProcessResult error(String err) {
    return ProcessResult(
      0,
      21,
      '',
      err,
    );
  }
}
