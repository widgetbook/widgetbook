import 'package:widgetbook_git/widgetbook_git.dart';

import '../../bin/models/models.dart';
import '../../bin/models/publish_args.dart';
import '../../bin/review/devices/models/device_data.dart';
import '../../bin/review/locales/models/locale_data.dart';
import '../../bin/review/text_scale_factors/models/text_scale_factor_data.dart';
import '../../bin/review/themes/models/theme_data.dart';

class TestData {
  static final ciArgsData = CliArgs(
    apiKey: 'apiKey',
    branch: 'branch',
    commit: 'commit',
    gitProvider: 'gitProvider',
    gitHubToken: 'gitHubToken',
    prNumber: 'prNumber',
    baseBranch: 'baseBranch',
    path: 'path',
  );

  static final args = PublishArgs(
    apiKey: 'apiKey',
    branch: 'branch',
    commit: 'commit',
    gitProvider: 'gitProvider',
    gitHubToken: 'gitHubToken',
    prNumber: 'prNumber',
    baseBranch: 'baseBranch',
    baseSha: 'a' * 40,
    path: 'path',
    vendor: 'Local',
    repository: 'respository',
    actor: 'John Doe',
  );

  static const ciArgs = CiArgs(
    vendor: 'Local',
    repository: 'respository',
    actor: 'John Doe',
  );

  static final branches = BranchReference(
    'sha',
    'HEAD',
  );

  static Map<String, dynamic> uploadBuildInfo = <String, dynamic>{
    'project': 'projectId',
    'build': 'buildId'
  };

  static final ReviewData reviewData = ReviewData(
    useCases: [],
    buildId: 'buildId',
    projectId: 'projectId',
    baseSha: 'baseSha',
  );

  static final ThemeData themeData = ThemeData(name: 'name');
  static final LocaleData localeData = LocaleData(name: 'name');
  static final DeviceData deviceData = DeviceData(name: 'name');
  static final TextScaleFactorData textScaleFactorData =
      TextScaleFactorData(value: 1);

  static final List<ThemeData> themes = <ThemeData>[themeData];
  static final List<LocaleData> locales = <LocaleData>[localeData];
  static final List<DeviceData> devices = <DeviceData>[deviceData];
  static final List<TextScaleFactorData> testScaleFactors =
      <TextScaleFactorData>[textScaleFactorData];
}
