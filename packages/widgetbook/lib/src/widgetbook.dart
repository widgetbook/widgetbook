import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'addons/addons.dart';
import 'app/router.dart';
import 'messaging/messaging.dart';
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
    required this.appBuilder,
    required this.addons,
    this.directories = const <MultiChildNavigationNodeData>[],
  });

  final List<WidgetbookAddOn> addons;

  /// Children which host Packages, Folders, Categories, Components
  /// and Use cases.
  /// This can be used to organize the structure of the Widgetbook on a large
  /// scale.
  final List<MultiChildNavigationNodeData> directories;

  final AppBuilder appBuilder;

  /// A [Widgetbook] which uses cupertino theming via [CupertinoApp].
  static Widgetbook cupertino({
    required List<MultiChildNavigationNodeData> directories,
    required List<WidgetbookAddOn> addons,
    AppBuilder? appBuilder,
    Key? key,
  }) {
    return Widgetbook(
      key: key,
      directories: directories,
      addons: addons,
      appBuilder: appBuilder ?? cupertinoAppBuilder,
    );
  }

  /// A [Widgetbook] which uses material theming via [MaterialApp].
  static Widgetbook material({
    required List<MultiChildNavigationNodeData> directories,
    required List<WidgetbookAddOn> addons,
    AppBuilder? appBuilder,
    Key? key,
  }) {
    return Widgetbook(
      key: key,
      directories: directories,
      addons: addons,
      appBuilder: appBuilder ?? materialAppBuilder,
    );
  }

  @override
  State<Widgetbook> createState() => _WidgetbookState();
}

class _WidgetbookState extends State<Widgetbook> {
  late final GoRouter router;
  final NavigationBloc navigationBloc = NavigationBloc();

  @override
  void initState() {
    router = createRouter(
      addons: widget.addons,
      catalog: WidgetbookCatalog.fromDirectories(widget.directories),
      appBuilder: widget.appBuilder,
    );

    navigationBloc.add(
      LoadNavigationTree(
        directories: widget.directories,
      ),
    );

    // Sends a message with the json representation of Addon fields
    sendMessage(
      widget.addons.fold(
        {},
        (json, addon) {
          return json
            ..putIfAbsent(
              addon.slugName,
              () => addon.fields
                  .map(
                    (field) => field.toFullJson(),
                  )
                  .toList(),
            );
        },
      ),
    );

    super.initState();
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
