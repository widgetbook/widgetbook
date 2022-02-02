import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';
import 'package:widgetbook/src/zoom/zoom_provider.dart';

class ZoomHandle extends StatelessWidget {
  const ZoomHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ZoomProvider>();
    final state = provider.state;
    return Row(
      children: [
        const SizedBox(
          width: 16,
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
        Tooltip(
          message: 'Reset zoom',
          child: WorkbenchButton.icon(
            onPressed: provider.resetToNormal,
            child: Icon(
              Icons.replay,
              color: context.theme.hintColor,
            ),
          ),
        ),
        WorkbenchButton.icon(
          onPressed: provider.zoomOut,
          child: Icon(
            Icons.remove,
            color: context.theme.hintColor,
          ),
        ),
        WorkbenchButton.icon(
          onPressed: provider.zoomIn,
          child: Icon(
            Icons.add,
            color: context.theme.hintColor,
          ),
        ),
      ],
    );
  }
}
