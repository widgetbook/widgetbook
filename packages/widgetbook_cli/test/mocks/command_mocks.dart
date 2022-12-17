import 'dart:io';

import 'package:args/args.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

import '../../bin/api/widgetbook_http_client.dart';
import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/git/git_wrapper.dart';
import '../../bin/helpers/widgetbook_zip_encoder.dart';
import '../../bin/review/devices/device_parser.dart';
import '../../bin/review/locales/locales_parser.dart';
import '../../bin/review/text_scale_factors/text_scale_factor_parser.dart';
import '../../bin/review/themes/theme_parser.dart';
import '../../bin/std/stdin_wrapper.dart';

class MockLogger extends Mock implements Logger {}

class MockGitWrapper extends Mock implements GitWrapper {}

class MockPubUpdater extends Mock implements PubUpdater {}

class FakeProcessResult extends Fake implements ProcessResult {}

class MockProgress extends Mock implements Progress {}

class MockArgResults extends Mock implements ArgResults {}

class MockCiParserRunner extends Mock implements CiParserRunner {}

class MockCiParser extends Mock implements CiParser {}

class MockWidgetbookZipEncoder extends Mock implements WidgetbookZipEncoder {}

class MockGitDir extends Mock implements GitDir {}

class MockWidgetbookHttpClient extends Mock implements WidgetbookHttpClient {}

class MockLocalFileSystem extends Mock implements LocalFileSystem {}

class MockThemeParser extends Mock implements ThemeParser {}

class MockCiWrapper extends Mock implements CiWrapper {}

class MockStdInWrapper extends Mock implements StdInWrapper {}

class MockLocaleParser extends Mock implements LocaleParser {}

class MockDeviceParser extends Mock implements DeviceParser {}

class MockTextScaleFactorParser extends Mock implements TextScaleFactorParser {}

class MockPlatformWrapper extends Mock implements PlatformWrapper {}
