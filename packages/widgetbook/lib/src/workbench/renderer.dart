import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/rendering/rendering_provider.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class Renderer<CustomTheme> extends StatelessWidget {
  const Renderer({
    Key? key,
    required this.device,
    required this.locale,
    required this.localizationsDelegates,
    required this.theme,
    required this.deviceFrame,
    required this.useCaseBuilder,
  }) : super(key: key);

  final Device device;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final CustomTheme theme;
  final DeviceFrame deviceFrame;
  final Widget Function(BuildContext) useCaseBuilder;

  Widget _buildText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(device.name),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final renderingState =
        context.watch<RenderingProvider<CustomTheme>>().state;
    final workbenchProvider =
        context.watch<WorkbenchProvider<CustomTheme>>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (deviceFrame.allowsDevices) _buildText(),
        renderingState.localizationBuilder(
          context,
          workbenchProvider.locales,
          localizationsDelegates?.toList(),
          locale,
          renderingState.themeBuilder(
            context,
            theme,
            Builder(
              builder: (context) {
                return renderingState.deviceFrameBuilder(
                  context,
                  device,
                  deviceFrame,
                  renderingState.scaffoldBuilder(
                    context,
                    deviceFrame,
                    renderingState.useCaseBuilder(
                      context,
                      useCaseBuilder(context),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
