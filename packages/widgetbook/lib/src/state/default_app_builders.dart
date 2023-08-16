import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget widgetsAppBuilder(BuildContext context, Widget child) {
  return WidgetsApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: child,
  );
}

Widget materialAppBuilder(BuildContext context, Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: child,
    ),
  );
}

Widget cupertinoAppBuilder(BuildContext context, Widget child) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
}
