import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'addons/addons.dart';
import 'integrations/integrations.dart';
import 'models/models.dart';
import 'routing/app_router.dart';
import 'state/state.dart';

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
  const Widgetbook({
    super.key,
    required this.directories,
    required this.appBuilder,
    this.addons,
    this.integrations,
  });

  /// The directory structure of your [Widget] library.
  ///
  /// The available organizers are: [WidgetbookCategory], [WidgetbookFolder],
  /// [WidgetbookComponent] and [WidgetbookUseCase].
  ///
  /// Both [WidgetbookCategory] and [WidgetbookFolder] can contain sub folders
  /// and [WidgetbookComponent] elements. However, [WidgetbookComponent] can
  /// only contain [WidgetbookUseCase]s.
  final List<MultiChildNavigationNodeData> directories;

  /// A wrapper builder method for all [WidgetbookUseCase]s.
  final AppBuilder appBuilder;

  /// The list of add-ons for your [Widget] library
  final List<WidgetbookAddon>? addons;

  /// The list of integrations for your [Widget] library. Primarily used to
  /// integrate with Widgetbook Cloud via [WidgetbookCloudIntegration], but
  /// can also be used to integrate with third-party packages.
  final List<WidgetbookIntegration>? integrations;

  /// A [Widgetbook] with [CupertinoApp] as an [appBuilder].
  static Widgetbook cupertino({
    Key? key,
    required List<MultiChildNavigationNodeData> directories,
    AppBuilder appBuilder = cupertinoAppBuilder,
    List<WidgetbookAddon>? addons,
    List<WidgetbookIntegration>? integrations,
  }) {
    return Widgetbook(
      key: key,
      directories: directories,
      appBuilder: appBuilder,
      addons: addons,
      integrations: integrations,
    );
  }

  /// A [Widgetbook] with [MaterialApp] as an [appBuilder].
  static Widgetbook material({
    Key? key,
    required List<MultiChildNavigationNodeData> directories,
    AppBuilder appBuilder = materialAppBuilder,
    List<WidgetbookAddon>? addons,
    List<WidgetbookIntegration>? integrations,
  }) {
    return Widgetbook(
      key: key,
      directories: directories,
      appBuilder: appBuilder,
      addons: addons,
      integrations: integrations,
    );
  }

  @override
  State<Widgetbook> createState() => _WidgetbookState();
}

class _WidgetbookState extends State<Widgetbook> {
  late final AppRouter router;

  @override
  void initState() {
    super.initState();

    final initialState = WidgetbookState(
      appBuilder: widget.appBuilder,
      addons: widget.addons,
      integrations: widget.integrations,
      directories: widget.directories,
    );

    router = AppRouter(
      initialState: initialState,
    );

    widget.integrations?.forEach(
      (integration) => integration.onInit(initialState),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: Themes.dark,
      theme: Themes.light,
    );
  }
}
