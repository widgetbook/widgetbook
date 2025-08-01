import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgetbook.dart'; // @docImport

/// A [Widgetbook.appBuilder] that uses [WidgetsApp].
Widget widgetsAppBuilder(BuildContext context, Widget child) {
  return WidgetsApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: child,
  );
}

/// A [Widgetbook.appBuilder] that uses [MaterialApp].
Widget materialAppBuilder(BuildContext context, Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: child,
    ),
  );
}

/// A [Widgetbook.appBuilder] that uses [CupertinoApp].
Widget cupertinoAppBuilder(BuildContext context, Widget child) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
}
