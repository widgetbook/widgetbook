import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/themes/dark_theme.dart';
import 'package:meal_app/widgets/dashboard.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgetbook/widgetbook.dart';

@WidgetbookDeviceFrameBuilder()
DeviceFrameBuilderFunction frameBuilder = (
  BuildContext context,
  Device device,
  WidgetbookFrame frame,
  Orientation orientation,
  Widget child,
) {
  if (frame == WidgetbookFrame.defaultFrame()) {
    return WidgetbookDeviceFrame(
      orientation: orientation,
      device: device,
      child: child,
    );
  }

  if (frame == WidgetbookFrame.deviceFrame()) {
    final deviceInfo = mapDeviceToDeviceInfo(device);
    return DeviceFrame(
      orientation: orientation,
      device: deviceInfo,
      screen: child,
    );
  }

  return child;
};

@WidgetbookLocalizationBuilder()
LocalizationBuilderFunction localizationBuilder = (
  BuildContext context,
  List<Locale> supportedLocales,
  List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  Locale activeLocale,
  Widget child,
) {
  if (localizationsDelegates != null) {
    return Localizations(
      locale: activeLocale,
      delegates: localizationsDelegates,
      child: child,
    );
  }

  return child;
};

@WidgetbookScaffoldBuilder()
ScaffoldBuilderFunction scaffoldBuilder = (
  BuildContext context,
  WidgetbookFrame frame,
  Widget child,
) {
  if (frame.allowsDevices) {
    return Scaffold(
      body: child,
    );
  }

  return child;
};

@WidgetbookThemeBuilder()
ThemeBuilderFunction<CustomTheme> themeBuilder<CustomTheme>() => (
      BuildContext context,
      CustomTheme theme,
      Widget child,
    ) {
      if (theme is ThemeData) {
        return Theme(
          data: theme,
          child: child,
        );
      }
      if (theme is CupertinoThemeData) {
        return CupertinoTheme(
          data: theme,
          child: child,
        );
      }

      throw Exception(
        'You are using Widgetbook with custom theme data. '
        'Please provide an implementation for themeBuilder.',
      );
    };

@WidgetbookLocales()
final locales = [
  Locale('en'),
  Locale('de'),
  Locale('fr'),
];

@WidgetbookLocalizationDelegates()
final delegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

@WidgetbookApp.material(
  name: 'Meal App',
  frames: const [
    WidgetbookFrame(
      name: 'Widgetbook',
      allowsDevices: true,
    ),
    WidgetbookFrame(
      name: 'None',
      allowsDevices: false,
    ),
  ],
  devices: [Apple.iPhone12],
  textScaleFactors: [
    1,
    2,
    3,
  ],
  foldersExpanded: true,
  widgetsExpanded: true,
)
class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: getDarkTheme(context),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('de'),
        Locale('fr'),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
        ),
        body: Dashboard(),
      ),
    );
  }
}
