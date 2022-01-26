import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_state.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class DeviceRender extends ConsumerWidget {
  const DeviceRender({
    Key? key,
    required this.story,
  }) : super(key: key);

  final WidgetbookUseCase story;

  ThemeData getInjectedTheme(BuildContext context, InjectedThemeState state) {
    final brightness = ThemeProvider.of(context)!.state;

    if (brightness == ThemeMode.light && state.lightTheme != null) {
      return state.lightTheme!;
    }
    if (brightness == ThemeMode.dark && state.darkTheme != null) {
      return state.darkTheme!;
    }
    return state.lightTheme ?? state.darkTheme!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceProvider = DeviceProvider.of(context)!;
    final state = deviceProvider.state;

    final device = state.currentDevice;
    final resolution = device.resolution;

    final themeState = InjectedThemeProvider.of(context)!.state;

    final workbenchState = ref.watch(workbenchProvider);
    final localizationState = ref.watch(localizationProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(device.name),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          width: resolution.logicalSize.width,
          height: resolution.logicalSize.height,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: workbenchState.locale,
            localizationsDelegates: localizationState.localizationsDelegates,
            supportedLocales: localizationState.supportedLocales,
            themeMode: Theme.of(context).brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            home: AnimatedTheme(
              duration: Duration.zero,
              data: getInjectedTheme(context, themeState).copyWith(
                brightness: Theme.of(context).brightness,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
              ),
              child: Scaffold(
                body: story.builder(
                  context,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
