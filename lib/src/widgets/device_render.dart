import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/cubit/device/device_cubit.dart';
import 'package:widgetbook/src/cubit/injected_theme/injected_theme_cubit.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/models/resolution.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

class DeviceRender extends StatelessWidget {
  final Story story;
  const DeviceRender({
    Key? key,
    required this.story,
  }) : super(key: key);

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
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, state) {
        Device device = state.currentDevice;
        Resolution resolution = device.resolution;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(device.name),
            SizedBox(
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
              width: resolution.widthInPt,
              height: resolution.heightInPt,
              child: BlocBuilder<InjectedThemeCubit, InjectedThemeState>(
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: getInjectedTheme(context, state).copyWith(
                      pageTransitionsTheme: PageTransitionsTheme(
                        builders: {
                          TargetPlatform.iOS:
                              FadeUpwardsPageTransitionsBuilder(),
                          TargetPlatform.android:
                              FadeUpwardsPageTransitionsBuilder(),
                        },
                      ),
                    ),
                    home: Scaffold(
                      body: story.builder(
                        context,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
