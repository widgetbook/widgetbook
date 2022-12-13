import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';

import 'package:widgetbook/src/addons/frame_addon/frames/device_frame/device_setting_provider.dart';

class NoFrameAddon extends WidgetbookAddOn {
  NoFrameAddon()
      : super(
          icon: const Icon(Icons.phone),
          name: 'No Frame',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder(
            child,
          ),
          builder: _builder,
          getQueryParameter: _getQueryParameter,
        );
}

Widget _wrapperBuilder(
  Widget child,
) {
  return ChangeNotifierProvider(
    key: const ValueKey('NoFrameAddon'),
    create: (_) => DeviceSettingProvider(null),
    child: child,
  );
}

Map _getQueryParameter(BuildContext context) {
  return <String, dynamic>{};
}

Widget _builder(BuildContext context) {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      )
    ],
  );
}
