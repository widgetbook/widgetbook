import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:widgetbook/src/configure_non_web.dart'
    if (dart.library.html) 'package:widgetbook/src/configure_web.dart';
import 'package:widgetbook/src/devices/devices.dart';
import 'package:widgetbook/src/localization/localization.dart';
import 'package:widgetbook/src/models/app_info.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/rendering/render_mode.dart';
import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/src/rendering/rendering_state.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/routing/route_information_parser.dart';
import 'package:widgetbook/src/routing/story_router_delegate.dart';
import 'package:widgetbook/src/services/filter_service.dart';
import 'package:widgetbook/src/theming/theming.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class Widgetbook extends StatelessWidget {
  const Widgetbook({
    Key? key,
    required this.categories,
    this.devices = const [
      Apple.iPhone11,
      Apple.iPhone12,
      Apple.iPhone12Mini,
      Apple.iPhone12Pro,
      Samsung.s10,
      Samsung.s21ultra,
    ],
    required this.appInfo,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.localizationsDelegates,
    required this.themes,
    this.defaultTheme = ThemeMode.system,
    this.deviceFrameBuilder,
    this.localizationBuilder,
    this.themeBuilder,
    this.scaffoldBuilder,
    this.useCaseBuilder,
    this.renderModes,
    // TODO check if this works
  })  : assert(
          themes.length > 0,
          'please provide a theme by using one of these properties: '
          'lightTheme, darkTheme or themes',
        ),
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

  final List<WidgetbookTheme> themes;

  final List<RenderMode>? renderModes;

  final DeviceFrameBuilderFunction? deviceFrameBuilder;

  final LocalizationBuilderFunction? localizationBuilder;

  final ThemeBuilderFunction? themeBuilder;

  final ScaffoldBuilderFunction? scaffoldBuilder;

  final UseCaseBuilderFunction? useCaseBuilder;

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: ProviderContainer(),
      child: WidgetbookWrapper(
        categories: categories,
        appInfo: appInfo,
        devices: devices,
        defaultTheme: defaultTheme,
        supportedLocales: supportedLocales,
        localizationsDelegates: localizationsDelegates,
        themes: themes,
        renderModes: renderModes,
        deviceFrameBuilder: deviceFrameBuilder,
        localizationBuilder: localizationBuilder,
        themeBuilder: themeBuilder,
        scaffoldBuilder: scaffoldBuilder,
        useCaseBuilder: useCaseBuilder,
      ),
    );
  }
}

class WidgetbookWrapper extends ConsumerStatefulWidget {
  const WidgetbookWrapper({
    Key? key,
    required this.categories,
    this.devices = const [
      Apple.iPhone11,
      Apple.iPhone12,
      Apple.iPhone12Mini,
      Apple.iPhone12Pro,
      Samsung.s10,
      Samsung.s21ultra,
    ],
    required this.appInfo,
    required this.themes,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.localizationsDelegates,
    this.lightTheme,
    this.darkTheme,
    this.defaultTheme = ThemeMode.system,
    this.renderModes,
    this.deviceFrameBuilder,
    this.localizationBuilder,
    this.themeBuilder,
    this.scaffoldBuilder,
    this.useCaseBuilder,
  }) : super(key: key);

  /// Categories which host Folders and WidgetElements.
  /// This can be used to organize the structure of the Widgetbook on a large
  /// scale.
  final List<WidgetbookCategory> categories;

  /// The devices on which Stories are previewed.
  final List<Device> devices;

  /// Information about the app that is catalogued in the Widgetbook.
  final AppInfo appInfo;

  /// The `ThemeData` that is shown when the light theme is active.
  final WidgetbookTheme? lightTheme;

  /// The `ThemeData` that is shown when the dark theme is active.
  final WidgetbookTheme? darkTheme;

  /// The default theme mode Widgetbook starts with
  final ThemeMode defaultTheme;

  final Iterable<Locale> supportedLocales;

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final Iterable<WidgetbookTheme> themes;

  final List<RenderMode>? renderModes;

  final DeviceFrameBuilderFunction? deviceFrameBuilder;

  final LocalizationBuilderFunction? localizationBuilder;

  final ThemeBuilderFunction? themeBuilder;

  final ScaffoldBuilderFunction? scaffoldBuilder;

  final UseCaseBuilderFunction? useCaseBuilder;

  @override
  _WidgetbookState createState() => _WidgetbookState();
}

class _WidgetbookState extends ConsumerState<WidgetbookWrapper> {
  // TODO ugly hack
  late BuildContext contextWithProviders;

  SelectedStoryRepository selectedStoryRepository = SelectedStoryRepository();
  StoryRepository storyRepository = StoryRepository();

  @override
  void initState() {
    configureApp();
    _onHotReload();

    super.initState();
  }

  void _onHotReload() {
    ref.read(localizationProvider.notifier).hotReloadUpdate(
          localizationsDelegates: widget.localizationsDelegates?.toList(),
          supportedLocales: widget.supportedLocales.toList(),
        );
    ref.read(themingProvider.notifier).hotReloadUpdate(
          themes: widget.themes.toList(),
        );
    ref.read(devicesProvider.notifier).hotReloadUpdate(
          devices: widget.devices,
        );

    ref.read(renderingProvider.notifier)
      ..renderModesChanged(widget.renderModes)
      ..deviceFrameBuilderChanged(widget.deviceFrameBuilder)
      ..localizationBuilderChanged(widget.localizationBuilder)
      ..themeBuilderChanged(widget.themeBuilder)
      ..scaffoldBuilderChanged(widget.scaffoldBuilder)
      ..useCaseBuilderChanged(widget.useCaseBuilder);
  }

  @override
  void didUpdateWidget(covariant WidgetbookWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // TODO(jenshor): this is not working and throws errors
    _onHotReload();

    // TODO remove this and put into the Builders
    OrganizerProvider.of(contextWithProviders)!.update(widget.categories);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return OrganizerBuilder(
          initialState: OrganizerState.unfiltered(
            categories: widget.categories,
          ),
          storyRepository: storyRepository,
          selectedStoryRepository: selectedStoryRepository,
          filterService: const FilterService(),
          child: CanvasBuilder(
            selectedStoryRepository: selectedStoryRepository,
            storyRepository: storyRepository,
            child: ZoomBuilder(
              child: ThemeBuilder(
                themeMode: widget.defaultTheme,
                child: Builder(
                  builder: (context) {
                    contextWithProviders = context;
                    final canvasState = CanvasProvider.of(context)!.state;
                    final storiesState = OrganizerProvider.of(context)!.state;
                    final themeMode = ThemeProvider.of(context)!.state;

                    return MaterialApp.router(
                      routeInformationParser: StoryRouteInformationParser(
                        onRoute: (path) {
                          final stories =
                              StoryHelper.getAllStoriesFromCategories(
                            storiesState.allCategories,
                          );
                          final selectedStory =
                              selectStoryFromPath(path, stories);
                          CanvasProvider.of(context)!
                              .selectStory(selectedStory);
                        },
                      ),
                      routerDelegate: StoryRouterDelegate(
                        canvasState: canvasState,
                        appInfo: widget.appInfo,
                      ),
                      title: widget.appInfo.name,
                      debugShowCheckedModeBanner: false,
                      themeMode: themeMode,
                      darkTheme: Styles.darkTheme,
                      theme: Styles.lightTheme,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
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
