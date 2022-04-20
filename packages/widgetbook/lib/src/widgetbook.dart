import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/app_info/app_info.dart';
import 'package:widgetbook/src/app_info/app_info_provider.dart';
import 'package:widgetbook/src/extensions/list_extension.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/mouse_tool/tool_provider.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/navigation/organizer_state.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/translate/translate_provider.dart';
import 'package:widgetbook/src/utils/styles.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook/src/zoom/zoom_provider.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Describes the configuration for your [Widget] library.
///
/// [Widgetbook] is the central element in organizing your widgets into
/// Folders and UseCases.
/// In addition, [Widgetbook] allows you to specify
/// - the [Theme]s used by your application,
/// - the [Device]s on which you'd like to preview the catalogued widgets
/// - the [Locale]s used by your application
///
/// [Widgetbook] defines the following constructors for different themes
/// - [Widgetbook]<[CustomTheme]> if you use a [CustomTheme] for your app
/// - [Widgetbook.cupertino] if you use [CupertinoThemeData] for your app
/// - [Widgetbook.material] if you use [ThemeData] for your app
///
/// Note: if you use for instance both [CupertinoThemeData] and [ThemeData] in
/// your app, use the [Widgetbook]<[CustomTheme]> constructor with [CustomTheme]
/// set to [dynamic] or [Object] and see [ThemeBuilderFunction] for how to
/// render custom themes.
class Widgetbook<CustomTheme> extends StatefulWidget {
  /// Creates a new instance of [Widgetbook].
  ///
  /// The [themes] specifies a list of themes available for the app. The default
  /// theme is the first theme within the list.
  ///
  /// ### Localization
  ///
  /// The given `localizationDelegates` is required if you want to use the
  /// Localization options of [Widgetbook]. Make sure to provide the following
  /// delegates:
  /// - `AppLocalizations.delegate`
  /// - `GlobalMaterialLocalizations.delegate`
  /// - `GlobalWidgetsLocalizations.delegate`
  /// - `GlobalCupertinoLocalizations.delegate`
  ///
  /// Futhermore, make sure to provide all the [Locale]s within
  /// [supportedLocales] so Widgetbook can show all the [Locale]s supported by
  /// your app.
  /// The default [Locale] is the first [Locale] in [supportedLocales].
  /// [supportedLocales] defaults to a list with `Locale('us')` as a default.
  ///
  /// ### Builder Functions
  ///
  /// Widgetbook defines builder functions for previewing use cases. The
  /// following functions are defined and called in this order:
  /// - [localizationBuilder] allows you to specify how the currently active
  /// `locale` and the [localizationsDelegates] are injected into the
  /// [BuildContext].
  /// - [themeBuilder] allows you to specify how the currently active `theme` is
  /// injected into [BuildContext].
  /// - [deviceFrameBuilder] allows you to define how a [WidgetbookFrame] is build.
  /// This decides how the use case is embedded into a virtual device.
  /// See [DeviceFrameBuilderFunction] and [WidgetbookFrame]. For instance, this
  /// property can be used to wrap your usecase with the device frame of the
  /// [device_frame package](https://pub.dev/packages/device_frame).
  /// - [scaffoldBuilder] allows you to wrap the use case with a scaffold, for
  /// instance [Scaffold].
  /// - [useCaseBuilder] allows you to customize how a single use case is
  /// rendered. This can be used to wrap each use case with a specifiy widget,
  /// e.g. [Center].
  const Widgetbook({
    Key? key,
    required this.categories,
    List<Device>? devices,
    required this.appInfo,
    this.localizationsDelegates,
    required this.themes,
    this.deviceFrameBuilder,
    this.localizationBuilder,
    this.themeBuilder,
    this.scaffoldBuilder,
    this.useCaseBuilder,
    List<Locale>? supportedLocales,
    List<WidgetbookFrame>? frames,
    List<double>? textScaleFactors,
  })  : assert(
          categories.length > 0,
          'Please specify at least one $WidgetbookCategory.',
        ),
        assert(
          devices == null || devices.length > 0,
          'Please specify at least one $Device.',
        ),
        assert(
          textScaleFactors == null || textScaleFactors.length > 0,
          'Please specify at least one textScaleFactor.',
        ),
        assert(
          themes.length > 0,
          'Please specify at least one $WidgetbookTheme.',
        ),
        assert(
          frames == null || frames.length > 0,
          'Please specify at least one $WidgetbookFrame.',
        ),
        assert(
          supportedLocales == null || supportedLocales.length > 0,
          'Please specify at least one supported $Locale.',
        ),
        supportedLocales = supportedLocales ??
            const [
              Locale('us'),
            ],
        textScaleFactors = textScaleFactors ?? const [1],
        frames = frames ??
            const <WidgetbookFrame>[
              WidgetbookFrame(
                name: 'Widgetbook',
                allowsDevices: true,
              ),
              WidgetbookFrame(
                name: 'Device Frame',
                allowsDevices: true,
              ),
              WidgetbookFrame(
                name: 'None',
                allowsDevices: false,
              )
            ],
        devices = devices ??
            const [
              Apple.iPhone11,
              Apple.iPhone12,
              Samsung.s21ultra,
            ],
        super(key: key);

  /// Categories which host Folders and WidgetElements.
  /// This can be used to organize the structure of the Widgetbook on a large
  /// scale.
  final List<WidgetbookCategory> categories;

  /// The devices on which Stories are previewed.
  final List<Device> devices;

  /// Information about the app that is catalogued in the Widgetbook.
  final AppInfo appInfo;

  /// A list of supported [Locale]s.
  final List<Locale> supportedLocales;

  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final List<WidgetbookTheme<CustomTheme>> themes;

  final List<WidgetbookFrame> frames;

  /// A list of text scale factors to test for font size accessibility
  final List<double> textScaleFactors;

  final DeviceFrameBuilderFunction? deviceFrameBuilder;

  final LocalizationBuilderFunction? localizationBuilder;

  final ThemeBuilderFunction<CustomTheme>? themeBuilder;

  final ScaffoldBuilderFunction? scaffoldBuilder;

  final UseCaseBuilderFunction? useCaseBuilder;

  /// A [Widgetbook] which uses cupertino theming via [CupertinoThemeData].
  static Widgetbook<CupertinoThemeData> cupertino({
    required List<WidgetbookCategory> categories,
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
    required AppInfo appInfo,
    List<Device>? devices,
    List<WidgetbookFrame>? frames,
    List<Locale>? supportedLocales,
    List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    DeviceFrameBuilderFunction? deviceFrameBuilder,
    LocalizationBuilderFunction? localizationBuilder,
    ThemeBuilderFunction<CupertinoThemeData>? themeBuilder,
    ScaffoldBuilderFunction? scaffoldBuilder,
    UseCaseBuilderFunction? useCaseBuilder,
    List<double>? textScaleFactors,
    Key? key,
  }) {
    return Widgetbook<CupertinoThemeData>(
      key: key,
      categories: categories,
      themes: themes,
      appInfo: appInfo,
      devices: devices,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      deviceFrameBuilder: deviceFrameBuilder,
      localizationBuilder: localizationBuilder,
      themeBuilder: themeBuilder,
      scaffoldBuilder: scaffoldBuilder,
      useCaseBuilder: useCaseBuilder,
      frames: frames,
      textScaleFactors: textScaleFactors,
    );
  }

  /// A [Widgetbook] which uses material theming via [ThemeData].
  static Widgetbook<ThemeData> material({
    required List<WidgetbookCategory> categories,
    required List<WidgetbookTheme<ThemeData>> themes,
    required AppInfo appInfo,
    List<Device>? devices,
    List<WidgetbookFrame>? frames,
    List<Locale>? supportedLocales,
    List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    DeviceFrameBuilderFunction? deviceFrameBuilder,
    LocalizationBuilderFunction? localizationBuilder,
    ThemeBuilderFunction<ThemeData>? themeBuilder,
    ScaffoldBuilderFunction? scaffoldBuilder,
    UseCaseBuilderFunction? useCaseBuilder,
    List<double>? textScaleFactors,
    Key? key,
  }) {
    return Widgetbook<ThemeData>(
      key: key,
      categories: categories,
      themes: themes,
      appInfo: appInfo,
      devices: devices,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      deviceFrameBuilder: deviceFrameBuilder,
      localizationBuilder: localizationBuilder,
      themeBuilder: themeBuilder,
      scaffoldBuilder: scaffoldBuilder,
      useCaseBuilder: useCaseBuilder,
      frames: frames,
      textScaleFactors: textScaleFactors,
    );
  }

  @override
  State<Widgetbook<CustomTheme>> createState() =>
      _WidgetbookState<CustomTheme>();
}

class _WidgetbookState<CustomTheme> extends State<Widgetbook<CustomTheme>> {
  final StoryRepository storyRepository = StoryRepository();
  final SelectedStoryRepository selectedStoryRepository =
      SelectedStoryRepository();

  late OrganizerProvider organizerProvider;
  late PreviewProvider previewProvider;
  late AppInfoProvider appInfoProvider;
  late WorkbenchProvider<CustomTheme> workbenchProvider;
  late KnobsNotifier knobsNotifier;
  late GoRouter goRouter;

  @override
  void initState() {
    organizerProvider = OrganizerProvider(
      state: OrganizerState.unfiltered(categories: widget.categories),
      storyRepository: storyRepository,
    )..hotReload(widget.categories);
    previewProvider = PreviewProvider(
      storyRepository: storyRepository,
      selectedStoryRepository: selectedStoryRepository,
    );
    knobsNotifier = KnobsNotifier(selectedStoryRepository);
    appInfoProvider = AppInfoProvider(state: widget.appInfo);
    workbenchProvider = WorkbenchProvider<CustomTheme>(
      themes: widget.themes,
      locales: widget.supportedLocales,
      devices: widget.devices,
      frames: widget.frames,
      textScaleFactors: widget.textScaleFactors,
    );
    goRouter = createRouter(
      workbenchProvider: workbenchProvider,
      previewProvider: previewProvider,
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Widgetbook<CustomTheme> oldWidget) {
    organizerProvider.hotReload(widget.categories);
    workbenchProvider.hotReload(
      themes: widget.themes,
      locales: widget.supportedLocales,
      devices: widget.devices,
      frames: widget.frames,
      textScaleFactors: widget.textScaleFactors,
    );
    appInfoProvider.hotReload(widget.appInfo);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          key: ValueKey(
            widget.localizationsDelegates,
          ),
          create: (_) => LocalizationProvider(
            localizationsDelegates: widget.localizationsDelegates,
          ),
        ),
        ChangeNotifierProvider(
          key: ValueKey(
            widget.frames.hashCodeOfItems ^
                widget.deviceFrameBuilder.hashCode ^
                widget.localizationBuilder.hashCode ^
                widget.themeBuilder.hashCode ^
                widget.scaffoldBuilder.hashCode ^
                widget.useCaseBuilder.hashCode,
          ),
          create: (_) => RenderingProvider(
            frames: widget.frames,
            deviceFrameBuilder:
                widget.deviceFrameBuilder ?? defaultDeviceFrameBuilder,
            localizationBuilder:
                widget.localizationBuilder ?? defaultLocalizationBuilder,
            themeBuilder:
                widget.themeBuilder ?? defaultThemeBuilder<CustomTheme>(),
            scaffoldBuilder: widget.scaffoldBuilder ?? defaultScaffoldBuilder,
            useCaseBuilder: widget.useCaseBuilder ?? defaultUseCaseBuilder,
          ),
        ),
        ChangeNotifierProvider(create: (_) => ZoomProvider()),
        ChangeNotifierProvider(create: (_) => ToolProvider()),
        ChangeNotifierProvider(create: (_) => TranslateProvider()),
        ChangeNotifierProvider.value(value: knobsNotifier),
        ChangeNotifierProvider.value(value: workbenchProvider),
        ChangeNotifierProvider.value(value: organizerProvider),
        ChangeNotifierProvider.value(value: previewProvider),
        ChangeNotifierProvider.value(value: appInfoProvider),
      ],
      child: MaterialApp.router(
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        title: widget.appInfo.name,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        darkTheme: Styles.darkTheme,
        theme: Styles.lightTheme,
      ),
    );
  }

  WidgetbookUseCase? selectStoryFromPath(
    String? path,
    List<WidgetbookUseCase> stories,
  ) {
    final storyPath = path?.replaceFirst('/stories/', '') ?? '';
    WidgetbookUseCase? story;
    for (final element in stories) {
      if (element.path == storyPath) {
        story = element;
      }
    }
    return story;
  }
}
