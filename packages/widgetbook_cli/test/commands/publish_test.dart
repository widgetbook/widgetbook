import 'package:args/args.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widgetbook_git/widgetbook_git.dart';

import '../../bin/api/widgetbook_http_client.dart';
import '../../bin/ci_parser/ci_parser.dart';
import '../../bin/commands/commands.dart';
import '../../bin/helpers/helpers.dart';
import '../../bin/models/deployment_data.dart';
import '../../bin/models/review_data.dart';
import '../../bin/review/devices/device_parser.dart';
import '../../bin/review/locales/locales_parser.dart';
import '../../bin/review/text_scale_factors/text_scale_factor_parser.dart';
import '../../bin/review/themes/theme_parser.dart';
import '../helpers/test_data.dart';
import '../mocks/mocks.dart';

class FakeFile extends Fake implements File {}

class FakeDeploymentData extends Fake implements DeploymentData {}

class FakeReviewData extends Fake implements ReviewData {}

class FakeDirectory extends Fake implements Directory {}

void main() {
  group('$PublishCommand', () {
    late Logger logger;
    late GitDir gitDir;
    late CiWrapper ciWrapper;
    late ArgResults argResults;
    late PublishCommand publishCommand;
    late WidgetbookHttpClient widgetbookHttpClient;
    late WidgetbookZipEncoder widgetbookZipEncoder;
    late LocalFileSystem localFileSystem;
    late ThemeParser themeParser;
    late LocaleParser localeParser;
    late DeviceParser deviceParser;
    late TextScaleFactorParser textScaleFactorsParser;
    final tempDir = const LocalFileSystem().currentDirectory;

    Progress publishProgress() => logger.progress(
          'Uploading build',
        );

    setUp(() async {
      logger = MockLogger();
      gitDir = MockGitDir();
      argResults = MockArgResults();
      ciWrapper = MockCiWrapper();
      widgetbookHttpClient = MockWidgetbookHttpClient();
      widgetbookZipEncoder = MockWidgetbookZipEncoder();
      localFileSystem = MockLocalFileSystem();
      themeParser = MockThemeParser();

      localeParser = MockLocaleParser();
      deviceParser = MockDeviceParser();
      textScaleFactorsParser = MockTextScaleFactorParser();
      publishCommand = PublishCommand(
        logger: logger,
        widgetbookHttpClient: widgetbookHttpClient,
      )..testArgResults = argResults;

      when(() => logger.progress(any())).thenReturn(MockProgress());
      when(() => logger.progress(any())).thenReturn(MockProgress());

      when(() => argResults['api-key'] as String).thenReturn('Api-Key');
      when(() => argResults['git-provider'] as String).thenReturn('Local');

      registerFallbackValue(FakeFile());
      registerFallbackValue(FakeDeploymentData());
      registerFallbackValue(FakeReviewData());
      registerFallbackValue(FakeDirectory());
    });

    test('can be instantiated without any parameters', () {
      expect(PublishCommand.new, returnsNormally);
    });

    test(
        'exits with code 70 when Directory '
        'from "path" is not a Git folder', () async {
      const invalidPath = '/';
      when(() => argResults['path'] as String).thenReturn(invalidPath);

      final result = await publishCommand.run();
      expect(result, equals(ExitCode.software.code));

      verify(
        () => logger
            .progress(
              'Uploading build',
            )
            .fail(),
      ).called(1);

      verify(
        () => logger.err('Directory from "path" is not a Git folder'),
      ).called(1);
    });

    test(
        'exits with code 70 when CI/CD pipeline '
        'provider is currently not supported', () async {
      final publishCommand = PublishCommand(
        logger: logger,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          gitDir: gitDir,
          ciWrapper: ciWrapper,
        ),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);
      when(() => ciWrapper.isCI()).thenReturn(true);
      when(() => ciWrapper.isGithub()).thenReturn(false);
      when(() => ciWrapper.isBitBucket()).thenReturn(false);
      when(() => ciWrapper.isGitLab()).thenReturn(false);
      when(() => ciWrapper.isAzure()).thenReturn(false);

      final result = await publishCommand.run();
      expect(result, equals(ExitCode.software.code));

      verify(
        () => logger
            .err('Your CI/CD pipeline provider is currently not supported.'),
      ).called(1);
    });

    test(
        'exits with code 0 when user decides not to '
        'proceed with un-commited changes', () async {
      final publishCommand = PublishCommand(
        logger: logger,
        ciParserRunner: CiParserRunner(argResults: argResults, gitDir: gitDir),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);
      when(() => gitDir.getActorName())
          .thenAnswer((_) => Future.value('John Doe'));
      when(
        () => logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        ),
      ).thenReturn('no');

      when(() => gitDir.getRepositoryName())
          .thenAnswer((_) => Future.value('widgetbook'));
      final result = await publishCommand.run();
      expect(result, equals(ExitCode.success.code));

      verify(
        () => logger.warn('You have un-commited changes'),
      ).called(1);
      verify(
        () => logger.warn(
            'Uploading a new build to Widgetbook Cloud requires a commit SHA. '
            'Due to un-committed changes, we are using the commit SHA '
            'of your previous commit which can lead to the build being '
            'rejected due to an already existing build.'),
      ).called(1);
    });

    test(
      'throws $DirectoryNotFoundException when web folder is not found',
      () {
        final fileSystem = MemoryFileSystem.test();

        expect(
          () => publishCommand.getZipFile(fileSystem.directory('/web')),
          throwsA(const TypeMatcher<DirectoryNotFoundException>()),
        );
      },
    );

    test(
      'throws $ActorNotFoundException when actor is not found',
      () {
        expect(
          () => publishCommand.publishBuilds(
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs.copyWith(actor: null),
            gitDir: gitDir,
            publishProgress: publishProgress(),
            getZipFile: (fileSystem) => null,
          ),
          throwsA(const TypeMatcher<ActorNotFoundException>()),
        );
      },
    );

    test(
      'throws $RepositoryNotFoundException when respository is not found',
      () {
        expect(
          () => publishCommand.publishBuilds(
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs.copyWith(repository: null),
            gitDir: gitDir,
            publishProgress: publishProgress(),
            getZipFile: (fileSystem) => null,
          ),
          throwsA(const TypeMatcher<RepositoryNotFoundException>()),
        );
      },
    );

    test(
      'throws $UnableToCreateZipFileException when .zip file Could '
      'not be create for upload',
      () {
        when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

        expect(
          () => publishCommand.publishBuilds(
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs,
            gitDir: gitDir,
            publishProgress: publishProgress(),
            getZipFile: (fileSystem) => null,
          ),
          throwsA(const TypeMatcher<UnableToCreateZipFileException>()),
        );

        verify(
          () => publishProgress().update('Getting branches'),
        ).called(1);
      },
    );

    test(
      'throws $WidgetbookDeployException when '
      '[$WidgetbookHttpClient.uploadDeployment] encounters an $Exception',
      () {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

        when(
          () => widgetbookHttpClient.uploadDeployment(
            deploymentFile: any(
              named: 'deploymentFile',
            ),
            data: any(
              named: 'data',
            ),
          ),
        ).thenThrow(WidgetbookDeployException(message: 'Dio Error'));
        expect(
          () => publishCommand.uploadDeploymentInfo(
            file: file,
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs,
          ),
          throwsA(const TypeMatcher<WidgetbookDeployException>()),
        );
      },
    );

    test(
      'throws $WidgetbookPublishReviewException when '
      '[$WidgetbookHttpClient.uploadReview] encounters an $Exception',
      () {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

        when(
          () => widgetbookHttpClient.uploadReview(
            apiKey: any(
              named: 'apiKey',
            ),
            useCases: any(
              named: 'useCases',
            ),
            buildId: any(
              named: 'buildId',
            ),
            projectId: any(
              named: 'projectId',
            ),
            baseBranch: any(
              named: 'baseBranch',
            ),
            headBranch: any(
              named: 'headBranch',
            ),
            baseSha: any(
              named: 'baseSha',
            ),
            headSha: any(
              named: 'headSha',
            ),
            themes: any(
              named: 'themes',
            ),
            locales: any(
              named: 'locales',
            ),
            devices: any(
              named: 'devices',
            ),
            textScaleFactors: any(
              named: 'textScaleFactors',
            ),
          ),
        ).thenThrow(WidgetbookPublishReviewException(message: 'Dio Error'));
        expect(
          () => publishCommand.uploadReview(
            file: file,
            cliArgs: TestData.ciArgsData,
            ciArgs: TestData.ciArgs,
            reviewData: TestData.reviewData,
          ),
          throwsA(const TypeMatcher<WidgetbookPublishReviewException>()),
        );
      },
    );

    test(
      'uploadDeployment method returns a $Map when '
      '[$WidgetbookHttpClient.uploadDeployment] runs successfully',
      () async {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

        when(
          () => widgetbookHttpClient.uploadDeployment(
            deploymentFile: any(
              named: 'deploymentFile',
            ),
            data: any(
              named: 'data',
            ),
          ),
        ).thenAnswer((_) => Future.value(TestData.uploadBuildInfo));

        final results = await publishCommand.uploadDeploymentInfo(
          file: file,
          cliArgs: TestData.ciArgsData,
          ciArgs: TestData.ciArgs,
        );

        expect(
          results,
          isA<Map>(),
        );
      },
    );

    test(
      'delete zip',
      () {
        final fileSystem = MemoryFileSystem.test();
        final file = fileSystem.file('web.zip')..createSync();

        expect(file.existsSync(), isTrue);
        publishCommand.deleteZip(file);
        expect(file.existsSync(), isFalse);
      },
    );
    test('exits with code 0 when publishing a build succeeds', () async {
      final fileSystem = MemoryFileSystem.test();
      final file = fileSystem.file('web.zip')..createSync();

      final publishCommand = PublishCommand(
        fileSystem: localFileSystem,
        widgetbookHttpClient: widgetbookHttpClient,
        logger: logger,
        themeParser: themeParser,
        localeParser: localeParser,
        deviceParser: deviceParser,
        textScaleFactorsParser: textScaleFactorsParser,
        ciParserRunner: CiParserRunner(argResults: argResults, gitDir: gitDir),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);

      when(() => themeParser.parse())
          .thenAnswer((_) => Future.value(TestData.themes));

      when(() => localeParser.parse())
          .thenAnswer((_) => Future.value(TestData.locales));

      when(() => deviceParser.parse())
          .thenAnswer((_) => Future.value(TestData.devices));

      when(() => textScaleFactorsParser.parse())
          .thenAnswer((_) => Future.value(TestData.testScaleFactors));

      when(() => gitDir.getActorName())
          .thenAnswer((_) => Future.value('John Doe'));

      when(() => localFileSystem.directory(any<String>()))
          .thenAnswer((_) => fileSystem.directory('/'));
      when(
        () => logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        ),
      ).thenReturn('yes');

      when(() => gitDir.getRepositoryName())
          .thenAnswer((_) => Future.value('widgetbook'));

      when(
        () => widgetbookHttpClient.uploadDeployment(
          deploymentFile: any(
            named: 'deploymentFile',
          ),
          data: any(
            named: 'data',
          ),
        ),
      ).thenAnswer((_) => Future.value(TestData.uploadBuildInfo));

      when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

      when(() => widgetbookZipEncoder.encode(any())).thenReturn(file);
      final result = await publishCommand.run();
      expect(result, equals(ExitCode.success.code));

      verify(
        () => logger.progress(
          'Uploading build',
        ),
      ).called(1);

      verify(
        () => logger.warn('You have un-commited changes'),
      ).called(1);

      verify(
        () => logger.warn(
            'Uploading a new build to Widgetbook Cloud requires a commit SHA. '
            'Due to un-committed changes, we are using the commit SHA '
            'of your previous commit which can lead to the build being '
            'rejected due to an already existing build.'),
      ).called(1);
    });

    test('exits with code 0 when publishing a review succeeds', () async {
      final fileSystem = MemoryFileSystem.test();
      final file = fileSystem.file('web.zip')..createSync();

      final publishCommand = PublishCommand(
        fileSystem: localFileSystem,
        widgetbookHttpClient: widgetbookHttpClient,
        logger: logger,
        themeParser: themeParser,
        localeParser: localeParser,
        deviceParser: deviceParser,
        textScaleFactorsParser: textScaleFactorsParser,
        ciParserRunner: CiParserRunner(
          argResults: argResults,
          gitDir: gitDir,
        ),
      )..testArgResults = argResults;
      when(() => argResults['path'] as String).thenReturn(tempDir.path);

      when(() => argResults['base-branch'] as String).thenReturn('main');

      when(() => argResults['base-commit'] as String).thenReturn('base-commit');

      when(() => themeParser.parse())
          .thenAnswer((_) => Future.value(TestData.themes));

      when(() => localeParser.parse())
          .thenAnswer((_) => Future.value(TestData.locales));

      when(() => deviceParser.parse())
          .thenAnswer((_) => Future.value(TestData.devices));

      when(() => textScaleFactorsParser.parse())
          .thenAnswer((_) => Future.value(TestData.testScaleFactors));

      when(() => gitDir.getActorName())
          .thenAnswer((_) => Future.value('John Doe'));

      when(() => localFileSystem.directory(any<String>()))
          .thenAnswer((_) => fileSystem.directory('/'));
      when(
        () => logger.chooseOne(
          'Would you like to proceed anyways?',
          choices: ['no', 'yes'],
          defaultValue: 'no',
        ),
      ).thenReturn('yes');

      when(() => gitDir.getRepositoryName())
          .thenAnswer((_) => Future.value('widgetbook'));

      when(
        () => widgetbookHttpClient.uploadDeployment(
          deploymentFile: any(
            named: 'deploymentFile',
          ),
          data: any(
            named: 'data',
          ),
        ),
      ).thenAnswer((_) => Future.value(TestData.uploadBuildInfo));

      when(() => gitDir.branches()).thenAnswer((_) => Future.value([]));

      when(
        () => widgetbookHttpClient.uploadReview(
          apiKey: any(
            named: 'apiKey',
          ),
          useCases: any(
            named: 'useCases',
          ),
          buildId: any(
            named: 'buildId',
          ),
          projectId: any(
            named: 'projectId',
          ),
          baseBranch: any(
            named: 'baseBranch',
          ),
          headBranch: any(
            named: 'headBranch',
          ),
          baseSha: any(
            named: 'baseSha',
          ),
          headSha: any(
            named: 'headSha',
          ),
          themes: any(
            named: 'themes',
          ),
          locales: any(
            named: 'locales',
          ),
          devices: any(
            named: 'devices',
          ),
          textScaleFactors: any(
            named: 'textScaleFactors',
          ),
        ),
      ).thenAnswer((_) => Future.value());

      when(() => widgetbookZipEncoder.encode(any())).thenReturn(file);

      final result = await publishCommand.run();

      expect(result, equals(ExitCode.success.code));

      verify(
        () => logger.warn('You have un-commited changes'),
      ).called(1);
      verify(
        () => logger.warn(
            'Uploading a new build to Widgetbook Cloud requires a commit SHA. '
            'Due to un-committed changes, we are using the commit SHA '
            'of your previous commit which can lead to the build being '
            'rejected due to an already existing build.'),
      ).called(1);
    });
  });
}
