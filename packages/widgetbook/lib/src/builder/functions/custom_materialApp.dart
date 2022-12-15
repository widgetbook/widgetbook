import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/addons/addons.dart';

class CustomMaterialTheme extends StatelessWidget {
  const CustomMaterialTheme({
    super.key,
    required this.routerDelegate,
    required this.routeInformationParser,
    this.routeInformationProvider,
    this.backButtonDispatcher,
    this.debugShowGrid = false,
    this.title = '',
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.useInheritedMediaQuery = false,
    this.debugShowCheckedModeBanner = true,
    this.showSemanticsDebugger = false,
    this.checkerboardOffscreenLayers = false,
    this.checkerboardRasterCacheImages = false,
    this.showPerformanceOverlay = false,
    this.onGenerateTitle,
    this.shortcuts,
    this.actions,
    this.builder,
    this.locale,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.localizationsDelegates,
    this.restorationScopeId,
  });

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final bool useInheritedMediaQuery;
  final bool debugShowGrid;
  final bool debugShowCheckedModeBanner;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object> routeInformationParser;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final List<Locale> supportedLocales;
  final String title;
  final String Function(BuildContext)? onGenerateTitle;
  final BackButtonDispatcher? backButtonDispatcher;
  final RouterDelegate<Object> routerDelegate;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final bool showSemanticsDebugger;
  final bool checkerboardOffscreenLayers;
  final bool checkerboardRasterCacheImages;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final bool showPerformanceOverlay;
  final Locale? locale;
  final TransitionBuilder? builder;

  // We provide material and cupertino localization delegate even it will
  // probably not be used.
  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates sync* {
    if (localizationsDelegates != null) yield* localizationsDelegates!;
    yield material.DefaultMaterialLocalizations.delegate;
    yield cupertino.DefaultCupertinoLocalizations.delegate;
  }

  static HeroController createAppHeroController() {
    return HeroController(
      createRectTween: (Rect? begin, Rect? end) {
        return material.MaterialRectArcTween(begin: begin, end: end);
      },
    );
  }

  Widget _inspectorSelectButtonBuilder(
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return Container();
  }

  Widget _appBuilder(BuildContext context, Widget? child) {
    return builder != null
        ? builder!(context, child)
        : child ?? const SizedBox.shrink();
  }

  Widget _buildWidgetApp(BuildContext context) {
    Widget result = WidgetsApp.router(
      key: GlobalObjectKey(this),
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      builder: _appBuilder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: context.materialTheme.primaryColor,
      locale: locale,
      localizationsDelegates: _localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      localeListResolutionCallback: localeListResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      inspectorSelectButtonBuilder: _inspectorSelectButtonBuilder,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );

    if (!useInheritedMediaQuery) {
      result = MediaQuery.fromWindow(
        child: result,
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var result = _buildWidgetApp(context);
    result = Focus(
      canRequestFocus: false,
      onKey: (FocusNode node, RawKeyEvent event) {
        if (event is! RawKeyDownEvent ||
            event.logicalKey != LogicalKeyboardKey.escape) {
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
      child: result,
    );
    assert(() {
      if (debugShowGrid) {
        result = GridPaper(
          color: const Color(0xE0F9BBE0),
          interval: 8,
          subdivisions: 1,
          child: result,
        );
      }
      return true;
    }());

    return ScrollConfiguration(
      behavior: const _ScrollBehaviour(),
      child: HeroControllerScope(
        controller: createAppHeroController(),
        child: result,
      ),
    );
  }
}

class _ScrollBehaviour extends ScrollBehavior {
  /// Creates a MaterialScrollBehavior that decorates [Scrollable]s with
  /// [GlowingOverscrollIndicator]s and [Scrollbar]s based on the current
  /// platform and provided [ScrollableDetails].
  ///
  /// [MaterialScrollBehavior.androidOverscrollIndicator] specifies the
  /// overscroll indicator that is used on [TargetPlatform.android]. When null,
  /// [ThemeData.androidOverscrollIndicator] is used. If also null, the default
  /// overscroll indicator is the [GlowingOverscrollIndicator].
  const _ScrollBehaviour({
    super.androidOverscrollIndicator,
  }) : _androidOverscrollIndicator = androidOverscrollIndicator;

  final AndroidOverscrollIndicator? _androidOverscrollIndicator;

  @override
  TargetPlatform getPlatform(BuildContext context) =>
      context.materialTheme.platform;

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // When modifying this function, consider modifying the implementation in
    // the base class as well.
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        switch (getPlatform(context)) {
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
          // TODO add scrollbar
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.iOS:
            return child;
        }
    }
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    final indicator = _androidOverscrollIndicator ?? androidOverscrollIndicator;
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        switch (indicator) {
          case AndroidOverscrollIndicator.stretch:
            return StretchingOverscrollIndicator(
              axisDirection: details.direction,
              child: child,
            );
          case AndroidOverscrollIndicator.glow:
            continue glow;
        }
      glow:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: details.direction,
          color: context.materialTheme.backgroundColor,
          child: child,
        );
    }
  }
}
