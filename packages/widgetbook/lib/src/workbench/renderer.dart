import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/widgetbook.dart';

class Renderer<CustomTheme> extends StatelessWidget {
  const Renderer({
    Key? key,
    required this.device,
    required this.theme,
    required this.frame,
    required this.textScaleFactor,
    required this.orientation,
    required this.useCaseBuilder,
  }) : super(key: key);

  final Device device;
  final CustomTheme theme;
  final WidgetbookFrame frame;
  final double textScaleFactor;
  final Orientation orientation;
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

  Widget _buildPreview(
    BuildContext context, {
    required List<WidgetbookAddOn> addons,
    WidgetbookAddOn? multiPropertyAddon,
    required RenderingState renderingState,
    required int index,
  }) {
    return MultiProvider(
      providers: [
        if (multiPropertyAddon != null)
          multiPropertyAddon.providerBuilder(context, index),
        ...addons
            .where((element) => element != multiPropertyAddon)
            .map((e) => e.providerBuilder(context, 0))
            .toList(),
      ],
      child: Builder(
        builder: (context) {
          return renderingState.deviceFrameBuilder(
            context,
            device,
            frame,
            orientation,
            Builder(
              builder: (context) {
                return renderingState.appBuilder(
                  context,
                  Builder(
                    builder: (context) {
                      return Builder(
                        builder: (context) {
                          return renderingState.scaffoldBuilder(
                            context,
                            frame,
                            Builder(
                              builder: (context) {
                                return renderingState.useCaseBuilder(
                                  context,
                                  Builder(
                                    builder: useCaseBuilder,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final renderingState =
        context.watch<RenderingProvider<CustomTheme>>().state;
    final addons = context.watch<AddOnProvider>().value;
    final multiPropertyAddons =
        addons.where((addon) => addon.selectionCount(context) > 1).toList();
    final multiPropertyAddon =
        multiPropertyAddons.isNotEmpty ? multiPropertyAddons.first : null;

    if (multiPropertyAddon == null) {
      return _buildPreview(
        context,
        addons: addons,
        renderingState: renderingState,
        index: 0,
      );
    } else {
      return Row(
        children: Iterable.generate(
          multiPropertyAddon.selectionCount(context),
          (value) => _buildPreview(
            context,
            addons: addons,
            multiPropertyAddon: multiPropertyAddon,
            renderingState: renderingState,
            index: value,
          ),
        ).toList(),
      );
    }
  }
}
