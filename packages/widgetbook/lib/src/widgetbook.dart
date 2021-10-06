import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/app_info.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_provider.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/routing/route_information_parser.dart';
import 'package:widgetbook/src/routing/story_router_delegate.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'configure_non_web.dart' if (dart.library.html) 'configure_web.dart';

class Widgetbook extends StatefulWidget {
  /// Categories which host Folders and WidgetElements.
  /// This can be used to organize the structure of the Widgetbook on a large scale.
  final List<Category> categories;

  /// The devices on which Stories are previewed.
  final List<Device> devices;

  /// Information about the app that is catalogued in the Widgetbook.
  final AppInfo appInfo;

  /// The `ThemeData` that is shown when the light theme is active.
  final ThemeData? lightTheme;

  /// The `ThemeData` that is shown when the dark theme is active.
  final ThemeData? darkTheme;

  const Widgetbook({
    Key? key,
    required this.categories,
    this.devices = const [
      Apple.iPhone11,
      Apple.iPhone12,
      Apple.iPhone12mini,
      Apple.iPhone12pro,
      Samsung.s10,
      Samsung.s21ultra,
    ],
    required this.appInfo,
    this.lightTheme,
    this.darkTheme,
  }) : super(key: key);

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
      categories: widget.categories,
      storyRepository: storyRepository,
      selectedStoryRepository: selectedStoryRepository,
      child: CanvasBuilder(
        selectedStoryRepository: selectedStoryRepository,
        storyRepository: storyRepository,
        child: ZoomBuilder(
          child: ThemeBuilder(
            child: DeviceBuilder(
              availableDevices: widget.devices,
              currentDevice: widget.devices.first,
              child: InjectedThemeBuilder(
                lightTheme: widget.lightTheme,
                darkTheme: widget.darkTheme,
                child: Builder(builder: (context) {
                  contextWithProviders = context;
                  var canvasState = CanvasProvider.of(context)!.state;
                  var storiesState = OrganizerProvider.of(context)!.state;
                  var themeMode = ThemeProvider.of(context)!.state;
                  return MaterialApp.router(
                    routeInformationParser: StoryRouteInformationParser(
                      onRoute: (path) {
                        var stories = StoryHelper.getAllStoriesFromCategories(
                          storiesState.allCategories,
                        );
                        var selectedStory = selectStoryFromPath(path, stories);
                        CanvasProvider.of(context)!.selectStory(selectedStory);
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

  Story? selectStoryFromPath(
    String? path,
    List<Story> stories,
  ) {
    String storyPath = path?.replaceFirst('/stories/', '') ?? '';
    Story? story;
    for (final element in stories) {
      if (element.path == storyPath) {
        story = element;
      }
    }
    return story;
  }
}
