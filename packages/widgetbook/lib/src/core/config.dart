import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../state/default_home_page.dart';
import 'core.dart';

/// Function signature for building the app wrapper around use cases.
///
/// The [AppBuilder] receives a [BuildContext] and the child widget (use case)
/// and should return a widget that wraps the child with the appropriate
/// app-level widgets like [MaterialApp], [CupertinoApp], or [WidgetsApp].
typedef AppBuilder = Widget Function(BuildContext context, Widget child);

Widget widgetsAppBuilder(BuildContext context, Widget child) {
  return WidgetsApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: child,
  );
}

Widget materialAppBuilder(BuildContext context, Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: child,
    ),
  );
}

Widget cupertinoAppBuilder(BuildContext context, Widget child) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
}

class Config {
  const Config({
    this.initialRoute = '/',
    this.components = const [],
    this.appBuilder = materialAppBuilder,
    this.home = const DefaultHomePage(),
    this.addons,
    this.integrations,
    this.lightTheme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.header,
    this.scrollBehavior = const MaterialScrollBehavior(),
    this.scenarios = const [],
  });

  /// The initial route for that will be used on first startup.
  final String initialRoute;

  /// The list of [Component]s that will be displayed in Widgetbook.
  final List<Component> components;

  /// For each [ScenarioDefinition] a [Scenario] will be created for every
  /// [Story] of every [Component].
  final List<ScenarioDefinition> scenarios;

  /// A wrapper builder method for all [Component]s.
  final AppBuilder appBuilder;

  /// The list of add-ons for your [Widget] library
  final List<Addon>? addons;

  /// The list of integrations for your [Widget] library.
  final List<Integration>? integrations;

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
  /// This parameter allows you to set the theme to light, dark,
  /// or follow the system setting. By default, it follows the system theme.
  final ThemeMode themeMode;

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
}
