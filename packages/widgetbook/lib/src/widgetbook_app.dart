import 'package:flutter/material.dart';
// ignore: unnecessary_import flutter(<3.35.0)
import 'package:meta/meta.dart';

import 'core/config.dart';
import 'routing/routing.dart';
import 'state/state.dart';
import 'theme/theme.dart';

@internal
class WidgetbookApp extends StatefulWidget {
  const WidgetbookApp({
    super.key,
    this.config = const Config(),
  });

  final Config config;

  @override
  State<WidgetbookApp> createState() => _WidgetbookAppState();
}

class _WidgetbookAppState extends State<WidgetbookApp> {
  late final WidgetbookState state;
  late final AppRouter router;

  @override
  void initState() {
    super.initState();

    state = WidgetbookState(config: widget.config);
    router = AppRouter(
      state: state,
      // Do not use the initial route if there is an existing URL fragment.
      // That means that the user has navigated to a different route then
      // they restarted the app, so we should not override that.
      uri: Uri.base.fragment.isNotEmpty
          ? Uri.parse(Uri.base.fragment)
          : Uri.parse(widget.config.initialRoute),
    );

    widget.config.integrations?.forEach(
      (integration) => integration.onInit(state),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final themeMode = widget.config.themeMode;
    final lightTheme = widget.config.lightTheme ?? Themes.light;
    final darkTheme = widget.config.darkTheme ?? Themes.dark;

    final targetThemeData = switch (themeMode) {
      ThemeMode.light => lightTheme,
      ThemeMode.dark => darkTheme,
      ThemeMode.system =>
        brightness == Brightness.light ? lightTheme : darkTheme,
    };

    // The app has two themes currently:
    // 1. The WidgetbookTheme - used to get Widgetbook theme below the MaterialThemeAddon
    // 2. The MaterialApp Theme - used to style the Material widgets in the app
    return WidgetbookTheme(
      data: targetThemeData,
      child: WidgetbookScope(
        state: state,
        child: MaterialApp.router(
          title: 'Widgetbook',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          scrollBehavior: widget.config.scrollBehavior,
          routerConfig: router,
        ),
      ),
    );
  }
}
