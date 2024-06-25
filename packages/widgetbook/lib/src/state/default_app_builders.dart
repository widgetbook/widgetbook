import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@Deprecated('Use [widgetBuilder] instead.')
Widget widgetsAppBuilder(BuildContext context, Widget child) {
  return WidgetsApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: child,
  );
}

@Deprecated('Use [materialBuilder] instead.')
Widget materialAppBuilder(BuildContext context, Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: child,
    ),
  );
}

@Deprecated('Use [cupertinoBuilder] instead.')
Widget cupertinoAppBuilder(BuildContext context, Widget child) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
}
