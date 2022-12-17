import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meal_app/themes/dark_theme.dart';
import 'package:meal_app/widgets/dashboard.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookLocales()
final locales = <Locale>[
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
