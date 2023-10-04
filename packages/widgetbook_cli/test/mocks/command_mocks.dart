import 'dart:io';

import 'package:args/args.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform/platform.dart';
import 'package:process/process.dart';
import 'package:pub_updater/pub_updater.dart';

import '../../bin/api/api.dart';
import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/git/git_dir.dart';
import '../../bin/git/git_manager.dart';
import '../../bin/review/use_case_reader.dart';

class MockLogger extends Mock implements Logger {}

class MockGitWrapper extends Mock implements GitManager {}

class MockPubUpdater extends Mock implements PubUpdater {}

class FakeProcessResult extends Fake implements ProcessResult {}

class MockProgress extends Mock implements Progress {}

class MockArgResults extends Mock implements ArgResults {}

class MockCiParserRunner extends Mock implements CiParserRunner {}

class MockCiParser extends Mock implements CiParser {}

class MockGitDir extends Mock implements GitDir {}

class MockWidgetbookHttpClient extends Mock implements WidgetbookHttpClient {}

class MockLocalFileSystem extends Mock implements LocalFileSystem {}

class MockCiWrapper extends Mock implements CiWrapper {}

class MockPlatform extends Mock implements Platform {}

class MockUseCaseReader extends Mock implements UseCaseReader {}

class MockStdin extends Mock implements Stdin {}

class MockProcessManager extends Mock implements ProcessManager {}

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
