import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/rendering/render_mode.dart';
import 'package:widgetbook/src/rendering/rendering_provider.dart';
import 'package:widgetbook/src/workbench/iteration_button.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:provider/provider.dart';

class RenderHandle<CustomTheme> extends ConsumerWidget {
  const RenderHandle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;

    final renderingState = ref.watch(getRenderingProvider<CustomTheme>());

    return Row(
      children: [
        IterationButton.left(onPressed: workbenchProvider.previousRenderMode),
        ...renderingState.renderModes
            .map(
              (e) => SelectionItem<RenderMode>(
                name: e.name,
                selectedItem: workbenchState.renderMode,
                item: e,
                onPressed: () {
                  workbenchProvider.changedRenderMode(e);
                },
              ),
            )
            .toList(),
        IterationButton.right(onPressed: workbenchProvider.nextRenderMode),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
