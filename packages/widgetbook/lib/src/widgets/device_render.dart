import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
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
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.light && state.lightTheme != null) {
      return state.lightTheme!;
    }
    if (brightness == Brightness.dark && state.darkTheme != null) {
      return state.darkTheme!;
    }

    log('''
No theme was provided for the set brightness.
 The theme of widgetbook is used to render your widgets.
 This may cause your widgets to look different.''');
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
