import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgetbook_state.dart';

Widget widgetsBuilder(
  BuildContext context,
  AddonsBuilder addonsBuilder,
  Widget useCase,
) {
  return WidgetsApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    builder: (context, child) => addonsBuilder(context, child!),
    home: useCase,
  );
}

Widget materialBuilder(
  BuildContext context,
  AddonsBuilder addonsBuilder,
  Widget useCase,
) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: (context, child) => addonsBuilder(context, child!),
    home: useCase,
  );
}

Widget cupertinoBuilder(
  BuildContext context,
  AddonsBuilder addonsBuilder,
  Widget useCase,
) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    builder: (context, child) => addonsBuilder(context, child!),
    home: useCase,
  );
}
