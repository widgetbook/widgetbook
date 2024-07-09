// ignore_for_file: deprecated_member_use_from_same_package

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
    this.appBuilder = widgetsAppBuilder,
    this.builder = widgetsBuilder,
    this.addons,
    this.integrations,
  }) : assert(
          appBuilder == cupertinoAppBuilder || builder == cupertinoBuilder,
          'Cannot provide both [appBuilder] and [builder] at the same time. '
          'Replace your [appBuilder] with [builder].',
        );

  /// A [Widgetbook] with [CupertinoApp] as an [appBuilder].
  const Widgetbook.cupertino({
    super.key,
    this.initialRoute = '/',
    required this.directories,
    this.appBuilder = cupertinoAppBuilder,
    this.builder = cupertinoBuilder,
    this.addons,
    this.integrations,
  }) : assert(
          appBuilder == cupertinoAppBuilder || builder == cupertinoBuilder,
          'Cannot provide both [appBuilder] and [builder] at the same time. '
          'Replace your [appBuilder] with [builder].',
        );

  /// A [Widgetbook] with [MaterialApp] as an [appBuilder].
  const Widgetbook.material({
    super.key,
    this.initialRoute = '/',
    required this.directories,
    this.appBuilder = materialAppBuilder,
    this.builder = materialBuilder,
    this.addons,
    this.integrations,
  }) : assert(
          appBuilder == materialAppBuilder || builder == materialBuilder,
          'Cannot provide both [appBuilder] and [builder] at the same time. '
          'Replace your [appBuilder] with [builder].',
        );

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
  @Deprecated('Use [builder] instead.')
  final AppBuilder appBuilder;

  /// Controls how the root [WidgetsApp] is built, and can be used to inject
  /// additional widgets into the widget tree.
  ///
  /// It provides three parameters:
  /// - [BuildContext], the current context.
  /// - [AddonsBuilder], function that wraps the child with [WidgetbookAddon]s.
  /// - [Widget], the current [WidgetbookUseCase].
  ///
  /// The [addonsBuilder] and [useCase] are separated to allow injecting
  /// widgets between them. For example, you might want to inject the
  /// [Navigator] below the addons, but above the use case, to make popup
  /// routes work properly with addons like [DeviceFrameAddon].
  ///
  /// ```dart
  /// builder: (context, addonsBuilder, useCase) {
  ///   return WidgetsApp(
  ///     // The child here is the [Navigator] widget,
  ///     // it will always be non-null, as [home] is provided.
  ///     builder: (context, child) => addonsBuilder(context, child!),
  ///     home: useCase,
  ///   );
  /// }
  /// ```
  final WidgetbookBuilder builder;

  /// The list of add-ons for your [Widget] library
  final List<WidgetbookAddon>? addons;

  /// The list of integrations for your [Widget] library. Primarily used to
  /// integrate with Widgetbook Cloud via [WidgetbookCloudIntegration], but
  /// can also be used to integrate with third-party packages.
  final List<WidgetbookIntegration>? integrations;

  @override
  State<Widgetbook> createState() => _WidgetbookState();
}

class _WidgetbookState extends State<Widgetbook> {
  late final WidgetbookState state;
  late final AppRouter router;

  @override
  void initState() {
    super.initState();

    final defaultAppBuilder = {
      widgetsAppBuilder,
      materialAppBuilder,
      cupertinoAppBuilder,
    };

    final isDefaultAppBuilder = defaultAppBuilder.any(
      (builder) => widget.appBuilder == builder,
    );

    state = WidgetbookState(
      // For backwards compatibility, we need to check if the appBuilder is set.
      // If the user is using the default appBuilder, then it is safe to migrate
      // them to the new flow of using builder.
      // If the user is setting a custom appBuilder, then we need to respect it
      // and give it a higher priority until they migrate to builder.
      // An assertion is used to prevent that both the appBuilder
      // and the builder are set together, because the latter will be ignored.
      builder: isDefaultAppBuilder
          ? widget.builder
          : (context, addonsBuilder, useCase) => widget.appBuilder(
                context,
                addonsBuilder(context, useCase),
              ),
      appBuilder: widget.appBuilder,
      addons: widget.addons,
      integrations: widget.integrations,
      root: WidgetbookRoot(
        children: widget.directories,
      ),
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
        title: 'Widgetbook',
        theme: Themes.light,
        darkTheme: Themes.dark,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
