import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/src/builder/builder.dart';

AppBuilderFunction get materialAppBuilder =>
    (BuildContext context, Widget child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
      );
    };

AppBuilderFunction get cupertinoAppBuilder =>
    (BuildContext context, Widget child) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: child,
      );
    };
