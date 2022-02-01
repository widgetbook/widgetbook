import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/configure_non_web.dart'
    if (dart.library.html) 'package:widgetbook/src/configure_web.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';

import 'package:widgetbook/src/models/app_info.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/story_helper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/mouse_tool/tool_provider.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';
import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/routing/route_information_parser.dart';
import 'package:widgetbook/src/routing/story_router_delegate.dart';
import 'package:widgetbook/src/services/filter_service.dart';
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
/// render the themes correctly.
class Widgetbook<CustomTheme> extends StatelessWidget {
  /// The given `localizationDelegates` is required if you want to use the
  /// Localization options of [Widgetbook]. Make sure to provide the following
  /// delegates:
  /// - `AppLocalizations.delegate`
  /// - `GlobalMaterialLocalizations.delegate`
  /// - `GlobalWidgetsLocalizations.delegate`
  /// - `GlobalCupertinoLocalizations.delegate`
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
    List<DeviceFrame>? deviceFrames,
  })  : assert(
          categories.length > 0,
          'Please specify at least one $WidgetbookCategory.',
        ),
        assert(
          devices == null || devices.length > 0,
          'Please specify at least one $Device.',
        ),
        assert(
          themes.length > 0,
          'Please specify at least one $WidgetbookTheme.',
        ),
        assert(
          deviceFrames == null || deviceFrames.length > 0,
          'Please specify at least one $DeviceFrame.',
        ),
        assert(
          supportedLocales == null || supportedLocales.length > 0,
          'Please specify at least one supported $Locale.',
        ),
        supportedLocales = supportedLocales ??
            const [
              Locale('us'),
            ],
        deviceFrames = deviceFrames ??
            const <DeviceFrame>[
              // TODO how to use the factory constructors here?
              DeviceFrame(
                name: 'Widgetbook',
                allowsDevices: true,
              ),
              DeviceFrame(
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

  final List<Locale> supportedLocales;

  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final List<WidgetbookTheme<CustomTheme>> themes;

  final List<DeviceFrame> deviceFrames;

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
    List<DeviceFrame>? deviceFrames,
    List<Locale>? supportedLocales,
    List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    DeviceFrameBuilderFunction? deviceFrameBuilder,
    LocalizationBuilderFunction? localizationBuilder,
    ThemeBuilderFunction<CupertinoThemeData>? themeBuilder,
    ScaffoldBuilderFunction? scaffoldBuilder,
    UseCaseBuilderFunction? useCaseBuilder,
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
      deviceFrames: deviceFrames,
    );
  }

  /// A [Widgetbook] which uses material theming via [ThemeData].
  static Widgetbook<ThemeData> material({
    required List<WidgetbookCategory> categories,
    required List<WidgetbookTheme<ThemeData>> themes,
    required AppInfo appInfo,
    List<Device>? devices,
    List<DeviceFrame>? deviceFrames,
    List<Locale>? supportedLocales,
    List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    DeviceFrameBuilderFunction? deviceFrameBuilder,
    LocalizationBuilderFunction? localizationBuilder,
    ThemeBuilderFunction<ThemeData>? themeBuilder,
    ScaffoldBuilderFunction? scaffoldBuilder,
    UseCaseBuilderFunction? useCaseBuilder,
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
      deviceFrames: deviceFrames,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: ValueKey(
        key.hashCode ^
            categories.hashCode ^
            themes.hashCode ^
            appInfo.hashCode ^
            devices.hashCode ^
            supportedLocales.hashCode ^
            localizationsDelegates.hashCode ^
            deviceFrameBuilder.hashCode ^
            localizationBuilder.hashCode ^
            themeBuilder.hashCode ^
            scaffoldBuilder.hashCode ^
            useCaseBuilder.hashCode ^
            deviceFrames.hashCode,
      ),
      providers: [
        ChangeNotifierProvider(
          create: (_) => ZoomProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkbenchProvider(
            themes: themes,
            locales: supportedLocales,
            devices: devices,
            deviceFrames: deviceFrames,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LocalizationProvider(
            localizationsDelegates: localizationsDelegates,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RenderingProvider(
            deviceFrames: deviceFrames,
            deviceFrameBuilder: deviceFrameBuilder ?? defaultDeviceFrameBuilder,
            localizationBuilder:
                localizationBuilder ?? defaultLocalizationBuilder,
            themeBuilder: themeBuilder ?? defaultThemeBuilder<CustomTheme>(),
            scaffoldBuilder: scaffoldBuilder ?? defaultScaffoldBuilder,
            useCaseBuilder: useCaseBuilder ?? defaultUseCaseBuilder,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ToolProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TranslateProvider(),
        ),
      ],
      child: WidgetbookWrapper<CustomTheme>(
        categories: categories,
        appInfo: appInfo,
        devices: devices,
        supportedLocales: supportedLocales,
        localizationsDelegates: localizationsDelegates,
        themes: themes,
        deviceFrames: deviceFrames,
        deviceFrameBuilder: deviceFrameBuilder,
        localizationBuilder: localizationBuilder,
        themeBuilder: themeBuilder,
        scaffoldBuilder: scaffoldBuilder,
        useCaseBuilder: useCaseBuilder,
      ),
    );
  }
}

class WidgetbookWrapper<CustomTheme> extends StatefulWidget {
  const WidgetbookWrapper({
    Key? key,
    required this.categories,
    List<Device>? devices,
    required this.appInfo,
    required this.themes,
    Iterable<Locale>? supportedLocales,
    this.localizationsDelegates,
    this.defaultTheme = ThemeMode.system,
    required this.deviceFrames,
    this.deviceFrameBuilder,
    this.localizationBuilder,
    this.themeBuilder,
    this.scaffoldBuilder,
    this.useCaseBuilder,
  })  : supportedLocales = supportedLocales ??
            const <Locale>[
              Locale('en', 'US'),
            ],
        devices = devices ??
            const [
              Apple.iPhone11,
              Apple.iPhone12,
              Apple.iPhone12Mini,
              Apple.iPhone12Pro,
              Samsung.s10,
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

  /// The default theme mode Widgetbook starts with
  final ThemeMode defaultTheme;

  final Iterable<Locale> supportedLocales;

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final Iterable<WidgetbookTheme<CustomTheme>> themes;

  final List<DeviceFrame> deviceFrames;

  final DeviceFrameBuilderFunction? deviceFrameBuilder;

  final LocalizationBuilderFunction? localizationBuilder;

  final ThemeBuilderFunction<CustomTheme>? themeBuilder;

  final ScaffoldBuilderFunction? scaffoldBuilder;

  final UseCaseBuilderFunction? useCaseBuilder;

  @override
  _WidgetbookState<CustomTheme> createState() =>
      _WidgetbookState<CustomTheme>();
}

class _WidgetbookState<CustomTheme>
    extends State<WidgetbookWrapper<CustomTheme>> {
  // TODO ugly hack
  late BuildContext contextWithProviders;

  SelectedStoryRepository selectedStoryRepository = SelectedStoryRepository();
  StoryRepository storyRepository = StoryRepository();

  @override
  void initState() {
    configureApp();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant WidgetbookWrapper<CustomTheme> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // TODO remove this and put into the Builders
    OrganizerProvider.of(contextWithProviders)!.update(widget.categories);
  }

  @override
  Widget build(BuildContext context) {
    // TODO mit damian besprechen
    return Focus(
      onKeyEvent: (n, e) {
        if (e.logicalKey == LogicalKeyboardKey.keyV) {
          context.read<ToolProvider>().selecionTool();
          return KeyEventResult.handled;
        }
        if (e.logicalKey == LogicalKeyboardKey.keyM) {
          context.read<ToolProvider>().moveTool();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: OrganizerBuilder(
        initialState: OrganizerState.unfiltered(
          categories: widget.categories,
        ),
        storyRepository: storyRepository,
        selectedStoryRepository: selectedStoryRepository,
        filterService: const FilterService(),
        child: CanvasBuilder(
          selectedStoryRepository: selectedStoryRepository,
          storyRepository: storyRepository,
          child: Builder(
            builder: (context) {
              contextWithProviders = context;
              final canvasState = CanvasProvider.of(context)!.state;
              final storiesState = OrganizerProvider.of(context)!.state;

              return MaterialApp.router(
                routeInformationParser: StoryRouteInformationParser(
                  onRoute: (path) {
                    final stories = StoryHelper.getAllStoriesFromCategories(
                      storiesState.allCategories,
                    );
                    final selectedStory = selectStoryFromPath(path, stories);
                    CanvasProvider.of(context)!.selectStory(selectedStory);
                  },
                ),
                routerDelegate: StoryRouterDelegate<CustomTheme>(
                  canvasState: canvasState,
                  appInfo: widget.appInfo,
                ),
                title: widget.appInfo.name,
                debugShowCheckedModeBanner: false,
                darkTheme: Styles.darkTheme,
                theme: Styles.lightTheme,
              );
            },
          ),
        ),
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
