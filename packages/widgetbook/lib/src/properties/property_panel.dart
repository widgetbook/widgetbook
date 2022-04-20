import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/devices/device_handle.dart';
import 'package:widgetbook/src/localization/localization_handle.dart';
import 'package:widgetbook/src/rendering/render_handle.dart';
import 'package:widgetbook/src/text_scale/text_scale_handle.dart';
import 'package:widgetbook/src/theming/theme_handle.dart';
import 'package:widgetbook/src/workbench/orientation_handle.dart';

class PropertyPanel<CustomTheme> extends StatelessWidget {
  const PropertyPanel({Key? key}) : super(key: key);

  Widget _buildSpacing(BuildContext context) {
    return Divider(
      thickness: 4,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minWidth: 50, maxWidth: 400),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: Radii.defaultRadius,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: OrientationHandle<CustomTheme>(),
                  ),
                  _buildSpacing(context),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ThemeHandle<CustomTheme>(),
                  ),
                  _buildSpacing(context),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: RenderHandle<CustomTheme>(),
                  ),
                  _buildSpacing(context),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DeviceHandle<CustomTheme>(),
                  ),
                  _buildSpacing(context),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: LocalizationHandle<CustomTheme>(),
                  ),
                  _buildSpacing(context),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextScaleHandle<CustomTheme>(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
