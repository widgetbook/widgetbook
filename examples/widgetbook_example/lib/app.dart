import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgetbook_example/themes/dark_theme.dart';
import 'package:widgetbook_example/widgets/dashboard.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: darkTheme,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
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
