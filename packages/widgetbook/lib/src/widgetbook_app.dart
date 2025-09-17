import 'package:flutter/material.dart';
// ignore: unnecessary_import flutter(<3.35.0)
import 'package:meta/meta.dart';

import 'core/config.dart';
import 'routing/routing.dart';
import 'state/state.dart';
import 'theme/themes.dart';

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

    state = WidgetbookState(
      appBuilder: widget.config.appBuilder,
      home: widget.config.home,
      header: widget.config.header,
      addons: widget.config.addons,
      integrations: widget.config.integrations,
      components: widget.config.components,
    );

    router = AppRouter(
      state: state,
      // Do not use the initial route if there is an existing URL fragment.
      // That means that the user has navigated to a different route then
      // they restarted the app, so we should not override that.
      uri:
          Uri.base.fragment.isNotEmpty
              ? Uri.parse(Uri.base.fragment)
              : Uri.parse(widget.config.initialRoute),
    );

    widget.config.integrations?.forEach(
      (integration) => integration.onInit(state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetbookScope(
      state: state,
      child: MaterialApp.router(
        title: 'Widgetbook',
        debugShowCheckedModeBanner: false,
        themeMode: widget.config.themeMode,
        theme: widget.config.lightTheme ?? Themes.light,
        darkTheme: widget.config.darkTheme ?? Themes.dark,
        scrollBehavior: widget.config.scrollBehavior,
        routerConfig: router,
      ),
    );
  }
}
