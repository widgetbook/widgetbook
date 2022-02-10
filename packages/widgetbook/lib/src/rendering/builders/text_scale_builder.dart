import 'package:flutter/material.dart';

TextScaleBuilder get defaultTextScaleBuilder =>
    (BuildContext context, double textScaleFactor, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: textScaleFactor,
        ),
        child: child,
      );
    };

typedef TextScaleBuilder = Widget Function(
  BuildContext context,
  double textScaleFactor,
  Widget child,
);
