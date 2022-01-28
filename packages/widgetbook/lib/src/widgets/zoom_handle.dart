import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';

class ZoomHandle extends StatefulWidget {
  const ZoomHandle({Key? key}) : super(key: key);

  @override
  _ZoomHandleState createState() => _ZoomHandleState();
}

class _ZoomHandleState extends State<ZoomHandle> {
  @override
  Widget build(BuildContext context) {
    final state = ZoomProvider.of(context)!.state;
    return Row(
      children: [
        WorkbenchButton.icon(
          onPressed: ZoomProvider.of(context)!.zoomOut,
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
          onPressed: ZoomProvider.of(context)!.zoomIn,
          child: Icon(
            Icons.add,
            color: context.theme.hintColor,
          ),
        ),
        Tooltip(
          message: 'Reset zoom',
          child: WorkbenchButton.icon(
            onPressed: ZoomProvider.of(context)!.resetToNormal,
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
