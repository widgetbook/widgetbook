import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';
import 'package:widgetbook/src/zoom/zoom.dart';

class ZoomHandle extends ConsumerWidget {
  const ZoomHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(zoomProvider);
    return Row(
      children: [
        WorkbenchButton.icon(
          onPressed: ref.read(zoomProvider.notifier).zoomOut,
          child: Icon(
            Icons.remove,
            color: context.theme.hintColor,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                state.zoomLevel.toStringAsFixed(2),
                style: context.theme.textTheme.subtitle2!.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Text('zoom'),
          ],
        ),
        WorkbenchButton.icon(
          onPressed: ref.read(zoomProvider.notifier).zoomIn,
          child: Icon(
            Icons.add,
            color: context.theme.hintColor,
          ),
        ),
        Tooltip(
          message: 'Reset zoom',
          child: WorkbenchButton.icon(
            onPressed: ref.read(zoomProvider.notifier).resetToNormal,
            child: Icon(
              Icons.replay,
              color: context.theme.hintColor,
            ),
          ),
        ),
      ],
    );
  }
}
