import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addons/addons.dart';
import 'integrations/integrations.dart';
import 'navigation/navigation.dart';
import 'routing/routing.dart';
import 'state/default_home_page.dart';
import 'state/state.dart';
import 'themes.dart';

/// Describes the configuration for your [Widget] library.
///
/// [Widgetbook] is the central element in organizing your widgets into
/// folders and use cases.
///
/// [Widgetbook] defines the following constructors for different app types
/// - [Widgetbook] if you use a custom widget (e.g. [WidgetsApp]) for your app.
/// - [Widgetbook.cupertino] if you use [CupertinoApp] for your app.
/// - [Widgetbook.material] if you use [MaterialApp] for your app.
class Widgetbook extends StatefulWidget {
  /// A [Widgetbook] with [WidgetsApp] as an [appBuilder].
  /// Allows you to use a custom widget as the app builder.
  const Widgetbook({
    super.key,
    this.initialRoute = '/',
    required this.directories,
    this.appBuilder = widgetsAppBuilder,
    this.addons,
    this.integrations,
    this.lightTheme,
    this.darkTheme,
    this.themeMode,
    this.home = const DefaultHomePage(),
    this.header,
    this.scrollBehavior,
    this.enableLeafComponents = true,
  });

  /// A [Widgetbook] with [CupertinoApp] as an [appBuilder].
  const Widgetbook.cupertino({
    super.key,
    this.initialRoute = '/',
    required this.directories,
    this.appBuilder = cupertinoAppBuilder,
    this.addons,
    this.integrations,
    this.lightTheme,
    this.darkTheme,
    this.themeMode,
    this.home = const DefaultHomePage(),
    this.header,
    this.scrollBehavior,
    this.enableLeafComponents = true,
  });

  /// A [Widgetbook] with [MaterialApp] as an [appBuilder].
  const Widgetbook.material({
    super.key,
    this.initialRoute = '/',
    required this.directories,
    this.appBuilder = materialAppBuilder,
    this.addons,
    this.integrations,
    this.lightTheme,
    this.darkTheme,
    this.themeMode,
    this.home = const DefaultHomePage(),
    this.header,
    this.scrollBehavior,
    this.enableLeafComponents = true,
  });

  /// The initial route for that will be used on first startup.
  final String initialRoute;

  /// The directory structure of your [Widget] library.
  ///
  /// The available organizers are: [WidgetbookCategory], [WidgetbookFolder],
  /// [WidgetbookComponent] and [WidgetbookUseCase].
  ///
  /// Both [WidgetbookCategory] and [WidgetbookFolder] can contain sub folders
  /// and [WidgetbookComponent] elements. However, [WidgetbookComponent] can
  /// only contain [WidgetbookUseCase]s.
  final List<WidgetbookNode> directories;

  /// A wrapper builder method for all [WidgetbookUseCase]s.
  final AppBuilder appBuilder;

  /// The list of add-ons for your [Widget] library
  final List<WidgetbookAddon>? addons;

  /// The list of integrations for your [Widget] library.
  final List<WidgetbookIntegration>? integrations;

  /// The custom theme for the Widgetbook interface when using light mode.
  ///
  /// This theme will override the default light theme provided by Widgetbook.
  final ThemeData? lightTheme;

  /// The custom theme for the Widgetbook interface when using dark mode.
  ///
  /// This theme will override the default dark theme provided by Widgetbook.
  final ThemeData? darkTheme;

  /// The theme mode to be applied to the Widgetbook application.
  ///
  /// This parameter allows you to set the theme to light, dark, or follow the system setting.
  /// By default, it follows the system theme.
  final ThemeMode? themeMode;

  /// The home widget is a widget that is shown on startup when no use-case is
  /// selected. This widget does not inherit from the [appBuilder] or the
  /// [addons]; meaning that if `Theme.of(context)` is called inside this
  /// widget, then it will use Widgetbook's [lightTheme] or [darkTheme] and
  /// not the [Theme] from the [appBuilder] or the [ThemeAddon].
  final Widget home;

  /// An optional widget to display at the top of the navigation panel.
  /// This can be used for branding or additional information.
  final Widget? header;

  /// The [ScrollBehavior] to be applied to the Widgetbook application itself.
  ///
  /// This allows users to override the behavior of scrolling on both desktop
  /// and web, where dragging by mouse is disabled by default.
  ///
  /// When null, defaults to [MaterialScrollBehavior].
  ///
  /// See also: https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag
  final ScrollBehavior? scrollBehavior;

  /// Enables or disables the visibility of leaf components in the Widgetbook UI.
  /// By default, this is set to true.
  final bool enableLeafComponents;

  @override
  State<Widgetbook> createState() => _WidgetbookState();
}

class _WidgetbookState extends State<Widgetbook> {
  late final WidgetbookState state;
  late final AppRouter router;

  @override
  void initState() {
    super.initState();

    state = WidgetbookState(
      appBuilder: widget.appBuilder,
      home: widget.home,
      header: widget.header,
      addons: widget.addons,
      integrations: widget.integrations,
      enableLeafComponents: widget.enableLeafComponents,
      root: WidgetbookRoot(
        children: widget.directories,
      ),
    );

    router = AppRouter(
      state: state,
      // Do not use the initial route if there is an existing URL fragment.
      // That means that the user has navigated to a different route then
      // they restarted the app, so we should not override that.
      uri:
          Uri.base.fragment.isNotEmpty
              ? Uri.parse(Uri.base.fragment)
              : Uri.parse(widget.initialRoute),
    );

    widget.integrations?.forEach(
      (integration) => integration.onInit(state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetbookScope(
      state: state,
      child: MaterialApp.router(
        title: 'Widgetbook',
        themeMode: widget.themeMode ?? ThemeMode.system,
        theme: widget.lightTheme ?? Themes.light,
        darkTheme: widget.darkTheme ?? Themes.dark,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        scrollBehavior: widget.scrollBehavior,
      ),
    );
  }
}
