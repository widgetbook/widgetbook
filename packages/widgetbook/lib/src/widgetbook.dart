import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/builder/builder.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/src/repositories/selected_use_case_repository.dart';
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

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
/// - [Widgetbook]<[CustomTheme]> if you use a [CustomTheme] for your app
/// - [Widgetbook.cupertino] if you use [CupertinoThemeData] for your app
/// - [Widgetbook.material] if you use [ThemeData] for your app
///
/// Note: if you use for instance both [CupertinoThemeData] and [ThemeData] in
/// your app, use the [Widgetbook]<[CustomTheme]> constructor with [CustomTheme]
/// set to [dynamic] or [Object] and see [AppBuilderFunction] for how to
/// render custom themes.
class Widgetbook<CustomTheme> extends StatefulWidget {
  const Widgetbook({
    super.key,
    this.directories = const <MultiChildNavigationNodeData>[],
    required this.appBuilder,
    required this.addons,
  }) : assert(
          directories.length > 0,
          'Please specify at least one $MultiChildNavigationNodeData.',
        );

  final List<WidgetbookAddOn> addons;

  /// Children which host Packages, Folders, Categories, Components
  /// and Use cases.
  /// This can be used to organize the structure of the Widgetbook on a large
  /// scale.
  final List<MultiChildNavigationNodeData> directories;

  final AppBuilderFunction appBuilder;

  /// A [Widgetbook] which uses cupertino theming via [CupertinoThemeData].
  static Widgetbook<CupertinoThemeData> cupertino({
    required List<MultiChildNavigationNodeData> directories,
    required List<WidgetbookAddOn> addons,
    AppBuilderFunction? appBuilder,
    Key? key,
  }) {
    return Widgetbook<CupertinoThemeData>(
      key: key,
      directories: directories,
      addons: addons,
      appBuilder: appBuilder ?? cupertinoAppBuilder,
    );
  }

  /// A [Widgetbook] which uses material theming via [ThemeData].
  static Widgetbook<ThemeData> material({
    required List<MultiChildNavigationNodeData> directories,
    required List<WidgetbookAddOn> addons,
    AppBuilderFunction? appBuilder,
    Key? key,
  }) {
    return Widgetbook<ThemeData>(
      key: key,
      directories: directories,
      addons: addons,
      appBuilder: appBuilder ?? materialAppBuilder,
    );
  }

  @override
  State<Widgetbook<CustomTheme>> createState() =>
      _WidgetbookState<CustomTheme>();
}

class _WidgetbookState<CustomTheme> extends State<Widgetbook<CustomTheme>> {
  final SelectedUseCaseRepository selectedStoryRepository =
      SelectedUseCaseRepository();

  late BuilderProvider builderProvider;
  late UseCasesProvider useCasesProvider;
  late KnobsNotifier knobsNotifier;
  late GoRouter goRouter;
  final NavigationBloc navigationBloc = NavigationBloc();

  @override
  void initState() {
    builderProvider = BuilderProvider(appBuilder: widget.appBuilder);

    useCasesProvider = UseCasesProvider(
      selectedStoryRepository: selectedStoryRepository,
    )..loadFromDirectories(widget.directories);

    knobsNotifier = KnobsNotifier(selectedStoryRepository);
    navigationBloc.add(
      LoadNavigationTree(
        directories: widget.directories,
      ),
    );

    goRouter = createRouter(
      useCasesProvider: useCasesProvider,
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Widgetbook<CustomTheme> oldWidget) {
    useCasesProvider.loadFromDirectories(widget.directories);
    navigationBloc.add(LoadNavigationTree(directories: widget.directories));
    builderProvider.hotReload(appBuilder: widget.appBuilder);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: knobsNotifier),
        ChangeNotifierProvider.value(value: useCasesProvider),
        ChangeNotifierProvider.value(value: builderProvider),
        ChangeNotifierProvider(
          create: (_) => AddOnProvider(widget.addons),
        ),
      ],
      child: BlocProvider.value(
        value: navigationBloc,
        child: MaterialApp.router(
          routeInformationProvider: goRouter.routeInformationProvider,
          routeInformationParser: goRouter.routeInformationParser,
          routerDelegate: goRouter.routerDelegate,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          darkTheme: Themes.dark,
          theme: Themes.light,
        ),
      ),
    );
  }
}
