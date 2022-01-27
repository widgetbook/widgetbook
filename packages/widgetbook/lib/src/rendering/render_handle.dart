import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/rendering/render_mode.dart';
import 'package:widgetbook/src/rendering/rendering_provider.dart';
import 'package:widgetbook/src/workbench/iteration_button.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class RenderHandle<CustomTheme> extends ConsumerWidget {
  const RenderHandle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbench = ref.watch(getWorkbenchProvider<CustomTheme>().notifier);
    final renderingState = ref.watch(getRenderingProvider<CustomTheme>());

    return Row(
      children: [
        IterationButton.left(onPressed: workbench.previousRenderMode),
        ...renderingState.renderModes
            .map(
              (e) => SelectionItem<RenderMode>(
                iconData: e.icon,
                tooltip: e.name,
                selectedItem:
                    ref.watch(getWorkbenchProvider<CustomTheme>()).renderMode,
                item: e,
                onPressed: () {
                  workbench.changedRenderMode(e);
                },
              ),
            )
            .toList(),
        IterationButton.right(onPressed: workbench.nextRenderMode),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
