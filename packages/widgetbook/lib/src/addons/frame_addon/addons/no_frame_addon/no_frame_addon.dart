import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/no_frame_addon/no_frame_provider.dart';

class NoFrameAddon extends WidgetbookAddOn {
  NoFrameAddon()
      : super(
          name: 'No Frame',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder(
            child,
          ),
          providerBuilder: _providerBuilder,
          builder: _builder, //not necessary
          getQueryParameter: _getQueryParameter,
        );
}

SingleChildWidget _providerBuilder(BuildContext context) {
  return Provider(create: (context) => NoFrameProvider());
}

Widget _wrapperBuilder(
  Widget child,
) {
  return LayoutBuilder(
    builder: (builder, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: child,
      );
    },
  );
}

Map<String, String> _getQueryParameter(BuildContext context) {
  return {};
}

Widget _builder(BuildContext context) {
  return Container();
}
