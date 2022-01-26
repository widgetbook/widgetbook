import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/constants/constants.dart';
import 'package:widgetbook/src/localization/localization_handle.dart';
import 'package:widgetbook/src/widgets/device_handle.dart';
import 'package:widgetbook/src/widgets/theme_handle.dart';
import 'package:widgetbook/src/widgets/zoom_handle.dart';

class ControlsBar extends ConsumerWidget {
  const ControlsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                children: const [
                  ZoomHandle(),
                  SizedBox(
                    width: 40,
                  ),
                  ThemeHandle(),
                  SizedBox(
                    width: 40,
                  ),
                  DeviceHandle(),
                  SizedBox(
                    width: 40,
                  ),
                  LocalizationHandle(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
