import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/cubit/device/device_cubit.dart';
import 'package:widgetbook/cubit/injected_theme/injected_theme_cubit.dart';
import 'package:widgetbook/cubit/organizer/organizer_cubit.dart';
import 'package:widgetbook/cubit/theme/theme_cubit.dart';
import 'package:widgetbook/cubit/zoom/zoom_cubit.dart';
import 'package:widgetbook/models/app_info.dart';
import 'package:widgetbook/models/device.dart';
import 'package:widgetbook/models/organizers/organizers.dart';

import 'routing/router.dart';
import 'styled_widgets/styled_widgets.dart';
import 'utils/utils.dart';

class Firebook extends StatefulWidget {
  /// Categories that can contain folders or components that can display states.
  /// States will have widgets which you may click on and display the widget in
  /// the editor.
  final List<Category> categories;

  final List<Device> devices;

  final AppInfo appInfo;

  /// The `ThemeData` that is defaulted when the project is opened. This should
  /// be considered as the light theme.
  final ThemeData? lightTheme;

  /// The `ThemeData` used when the dark theme is enabled.
  final ThemeData? darkTheme;

  const Firebook({
    required this.categories,
    this.devices = const [
      Apple.iPhone11,
      Apple.iPhone12,
      Apple.iPhone12mini,
      Apple.iPhone12pro,
      Samsung.s10,
      Samsung.s21ultra,
    ],
    required this.appInfo,
    this.lightTheme,
    this.darkTheme,
  });

  @override
  _FirebookState createState() => _FirebookState();
}

class _FirebookState extends State<Firebook> {
  late OrganizerCubit storiesCubit;
  late DeviceCubit deviceCubit;
  late InjectedThemeCubit injectedThemeCubit;

  @override
  void initState() {
    storiesCubit = OrganizerCubit(categories: widget.categories);
    deviceCubit = DeviceCubit(devices: widget.devices);
    injectedThemeCubit = InjectedThemeCubit(
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Firebook oldWidget) {
    // This is done to adjust the state of the cubit
    // when the widgetbook is hot reloaded
    //
    // TODO check if this is the best way to do this
    storiesCubit.update(widget.categories);
    deviceCubit.update(widget.devices);
    injectedThemeCubit.themesChanged(
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CanvasCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => ZoomCubit(),
        ),
        BlocProvider(
          create: (context) => storiesCubit,
        ),
        BlocProvider(
          create: (context) => deviceCubit,
        ),
        BlocProvider(
          create: (context) => injectedThemeCubit,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<OrganizerCubit, OrganizerState>(
            builder: (context, storiesState) {
              return MaterialApp(
                title: 'Firebook',
                debugShowCheckedModeBanner: false,
                themeMode: themeMode,
                darkTheme: Styles.darkTheme,
                theme: Styles.lightTheme,
                builder: (context, child) {
                  return StyledScaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Navigator(
                        reportsRouteUpdateToEngine: true,
                        initialRoute: '/',
                        onGenerateRoute: (settings) => generateRoute(
                          context,
                          widget.appInfo,
                          settings.name,
                          settings: settings,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
