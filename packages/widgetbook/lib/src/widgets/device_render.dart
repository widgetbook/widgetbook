import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/models/resolution.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_state.dart';

class DeviceRender extends StatelessWidget {
  const DeviceRender({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Story story;

  ThemeData getInjectedTheme(BuildContext context, InjectedThemeState state) {
    var brightness = Theme.of(context).brightness;

    if (brightness == Brightness.light && state.lightTheme != null) {
      return state.lightTheme!;
    }
    if (brightness == Brightness.dark && state.darkTheme != null) {
      return state.darkTheme!;
    }

    // TODO a warning would probably be good because otherwise the rendering is not representative
    // As an alternative at least one Theme has to be provided,
    //and theme switching is disabled if no theme for light AND dark is provided.
    return Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final deviceProvider = DeviceProvider.of(context)!;
    final state = deviceProvider.state;

    final device = state.currentDevice;
    final resolution = device.resolution;

    final themeState = InjectedThemeProvider.of(context)!.state;

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
              width: 1,
            ),
          ),
          width: resolution.logicalSize.width,
          height: resolution.logicalSize.height,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getInjectedTheme(context, themeState).copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                },
              ),
            ),
            home: Scaffold(
              body: story.builder(
                context,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
