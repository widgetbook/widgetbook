import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
