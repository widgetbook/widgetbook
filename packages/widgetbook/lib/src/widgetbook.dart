import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgetbook/src/configure_non_web.dart'
    if (dart.library.html) 'package:widgetbook/src/configure_web.dart';
import 'package:widgetbook/src/models/app_info.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_provider.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/routing/route_information_parser.dart';
import 'package:widgetbook/src/routing/story_router_delegate.dart';
import 'package:widgetbook/src/services/filter_service.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class Widgetbook extends StatefulWidget {
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
    this.lightTheme,
    this.darkTheme,
    this.defaultTheme = ThemeMode.system,
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
  final ThemeData? lightTheme;

  /// The `ThemeData` that is shown when the dark theme is active.
  final ThemeData? darkTheme;

  /// The default theme mode Widgetbook starts with
  final ThemeMode defaultTheme;

  @override
  _WidgetbookState createState() => _WidgetbookState();
}

class _WidgetbookState extends State<Widgetbook> {
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
  void didUpdateWidget(covariant Widgetbook oldWidget) {
    // TODO remove this and put into the Builders
    OrganizerProvider.of(contextWithProviders)!.update(widget.categories);
    DeviceProvider.of(contextWithProviders)!.update(widget.devices);
    InjectedThemeProvider.of(contextWithProviders)!.themesChanged(
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
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
            child: DeviceBuilder(
              availableDevices: widget.devices,
              currentDevice: widget.devices.first,
              child: InjectedThemeBuilder(
                lightTheme: widget.lightTheme,
                darkTheme: widget.darkTheme,
                child: Builder(builder: (context) {
                  contextWithProviders = context;
                  final canvasState = CanvasProvider.of(context)!.state;
                  final storiesState = OrganizerProvider.of(context)!.state;
                  final themeMode = ThemeProvider.of(context)!.state;

                  return MaterialApp.router(
                    routeInformationParser: StoryRouteInformationParser(
                      onRoute: (path) {
                        final stories = StoryHelper.getAllStoriesFromCategories(
                          storiesState.allCategories,
                        );
                        final selectedStory =
                            selectStoryFromPath(path, stories);
                        unawaited(CanvasProvider.of(context)!
                            .selectStory(selectedStory));
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
                }),
              ),
            ),
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
