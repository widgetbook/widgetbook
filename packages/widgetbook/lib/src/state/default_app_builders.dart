import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgetbook_state.dart';

final AppBuilder materialAppBuilder = (
  BuildContext context,
  Widget child,
) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
};

final AppBuilder cupertinoAppBuilder = (
  BuildContext context,
  Widget child,
) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: child,
  );
};
