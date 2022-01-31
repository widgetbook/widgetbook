import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/constants.dart';
import 'package:widgetbook/src/devices/device_handle.dart';
import 'package:widgetbook/src/localization/localization_handle.dart';
import 'package:widgetbook/src/rendering/render_handle.dart';
import 'package:widgetbook/src/theming/theme_handle.dart';
import 'package:widgetbook/src/zoom/zoom_handle.dart';

class WorkbenchControls<CustomTheme> extends StatelessWidget {
  const WorkbenchControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.controlBarHeight,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ZoomHandle(),
                  const SizedBox(
                    width: 40,
                  ),
                  ThemeHandle<CustomTheme>(),
                  const SizedBox(
                    width: 40,
                  ),
                  DeviceHandle<CustomTheme>(),
                  const SizedBox(
                    width: 40,
                  ),
                  LocalizationHandle<CustomTheme>(),
                  const SizedBox(
                    width: 40,
                  ),
                  RenderHandle<CustomTheme>(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
