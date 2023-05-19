import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'addons/addons.dart';
import 'integrations/integrations.dart';
import 'routing/app_router.dart';
import 'state/state.dart';

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
/// - [Widgetbook] if you use a [WidgetsApp] for your app
/// - [Widgetbook.cupertino] if you use [CupertinoApp] for your app
/// - [Widgetbook.material] if you use [MaterialApp] for your app
class Widgetbook extends StatefulWidget {
  const Widgetbook({
    super.key,
    required this.directories,
    required this.appBuilder,
    this.addons,
    this.integrations,
  });

  /// Children which host Packages, Folders, Categories, Components
  /// and Use cases.
  /// This can be used to organize the structure of the Widgetbook on a large
  /// scale.
  final List<MultiChildNavigationNodeData> directories;

  final AppBuilder appBuilder;

  final List<WidgetbookAddOn>? addons;

  final List<WidgetbookIntegration>? integrations;

  /// A [Widgetbook] which uses cupertino theming via [CupertinoApp].
  static Widgetbook cupertino({
    Key? key,
    required List<MultiChildNavigationNodeData> directories,
    AppBuilder? appBuilder,
    List<WidgetbookAddOn>? addons,
    List<WidgetbookIntegration>? integrations,
  }) {
    return Widgetbook(
      key: key,
      directories: directories,
      appBuilder: appBuilder ?? cupertinoAppBuilder,
      addons: addons,
      integrations: integrations,
    );
  }

  /// A [Widgetbook] which uses material theming via [MaterialApp].
  static Widgetbook material({
    Key? key,
    required List<MultiChildNavigationNodeData> directories,
    AppBuilder? appBuilder,
    List<WidgetbookAddOn>? addons,
    List<WidgetbookIntegration>? integrations,
  }) {
    return Widgetbook(
      key: key,
      directories: directories,
      appBuilder: appBuilder ?? materialAppBuilder,
      addons: addons,
      integrations: integrations,
    );
  }

  @override
  State<Widgetbook> createState() => _WidgetbookState();
}

class _WidgetbookState extends State<Widgetbook> {
  final NavigationBloc navigationBloc = NavigationBloc();
  late final AppRouter router;

  @override
  void initState() {
    super.initState();

    final initialState = WidgetbookState(
      catalog: WidgetbookCatalog.fromDirectories(widget.directories),
      appBuilder: widget.appBuilder,
      addons: widget.addons,
      integrations: widget.integrations,
    );

    router = AppRouter(
      initialState: initialState,
    );

    widget.integrations?.forEach(
      (integration) => integration.onInit(initialState),
    );

    navigationBloc.add(
      LoadNavigationTree(
        directories: widget.directories,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant Widgetbook oldWidget) {
    navigationBloc.add(LoadNavigationTree(directories: widget.directories));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: navigationBloc,
      child: MaterialApp.router(
        routerConfig: router,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        darkTheme: Themes.dark,
        theme: Themes.light,
      ),
    );
  }
}
