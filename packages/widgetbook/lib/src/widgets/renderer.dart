import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class Renderer extends StatelessWidget {
  const Renderer({
    Key? key,
    required this.device,
    required this.locale,
    required this.localizationsDelegates,
    required this.theme,
    required this.useCaseBuilder,
  }) : super(key: key);

  final Device device;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final ThemeData theme;
  final Widget Function(BuildContext) useCaseBuilder;

  @override
  Widget build(BuildContext context) {
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
          width: device.resolution.logicalSize.width,
          height: device.resolution.logicalSize.height,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            localizationsDelegates: localizationsDelegates,
            supportedLocales: [
              locale,
            ],
            themeMode: Theme.of(context).brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            home: AnimatedTheme(
              duration: Duration.zero,
              data: theme,
              child: Scaffold(
                body: useCaseBuilder(
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
