import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addons/addons.dart';
import 'integrations/integrations.dart';
import 'navigation/navigation.dart';
import 'routing/routing.dart';
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
  const Widgetbook({
    super.key,
    this.initialRoute = '/',
    required this.directories,
    required this.appBuilder,
    this.addons,
    this.integrations,
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
  final List<TreeNode> directories;

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
    String initialRoute = '/',
    required List<TreeNode> directories,
    AppBuilder appBuilder = cupertinoAppBuilder,
    List<WidgetbookAddon>? addons,
    List<WidgetbookIntegration>? integrations,
  }) {
    return Widgetbook(
      key: key,
      initialRoute: initialRoute,
      directories: directories,
      appBuilder: appBuilder,
      addons: addons,
      integrations: integrations,
    );
  }

  /// A [Widgetbook] with [MaterialApp] as an [appBuilder].
  static Widgetbook material({
    Key? key,
    String initialRoute = '/',
    required List<TreeNode> directories,
    AppBuilder appBuilder = materialAppBuilder,
    List<WidgetbookAddon>? addons,
    List<WidgetbookIntegration>? integrations,
  }) {
    return Widgetbook(
      key: key,
      initialRoute: initialRoute,
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
  late final WidgetbookState state;
  late final AppRouter router;

  @override
  void initState() {
    super.initState();

    state = WidgetbookState(
      appBuilder: widget.appBuilder,
      addons: widget.addons,
      integrations: widget.integrations,
      directories: widget.directories,
    );

    router = AppRouter(
      initialRoute: Uri.base.fragment.isNotEmpty
          ? Uri.base.fragment
          : widget.initialRoute,
      state: state,
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
        routerConfig: router,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        darkTheme: Themes.dark,
        theme: Themes.light,
      ),
    );
  }
}
