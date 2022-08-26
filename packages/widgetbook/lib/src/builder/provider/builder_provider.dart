import 'package:flutter/material.dart';
import 'package:widgetbook/src/builder/models/builder_data.dart';

class BuilderProvider extends ValueNotifier<BuilderData> {
  BuilderProvider({
    required Widget Function(BuildContext, Widget child) appBuilder,
  }) : super(
          BuilderData(
            appBuilder: appBuilder,
          ),
        );

  void hotReload({
    required Widget Function(BuildContext, Widget child) appBuilder,
  }) {
    value = BuilderData(appBuilder: appBuilder);
  }
}
