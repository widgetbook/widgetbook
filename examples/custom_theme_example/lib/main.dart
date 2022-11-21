import 'package:custom_theme_example/app_theme.dart';
import 'package:flutter/material.dart';

import 'main.widgetbook.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppTheme(
        data: themeData,
        child: MediaQuery.fromWindow(
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: MyHomePage(),
          ),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'This is the home page',
            ),
          ],
        ),
      ),
    );
  }
}
