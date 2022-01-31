import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/localization/localization_provider.dart';
import 'package:widgetbook/src/rendering/device_frame.dart';
import 'package:widgetbook/src/rendering/rendering_provider.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:provider/provider.dart';

class Renderer<CustomTheme> extends ConsumerWidget {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renderingState =
        context.watch<RenderingProvider<CustomTheme>>().state;
    final workbenchProvider =
        context.watch<WorkbenchProvider<CustomTheme>>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(device.name),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Center(
            child: renderingState.localizationBuilder(
              context,
              workbenchProvider.locales,
              // TODO this should not be nullable
              localizationsDelegates!.toList(),
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
          ),
        ),
      ],
    );
  }
}
