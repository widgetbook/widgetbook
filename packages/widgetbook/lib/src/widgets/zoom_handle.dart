import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/utils/extensions.dart';

class ZoomHandle extends StatefulWidget {
  const ZoomHandle({Key? key}) : super(key: key);

  @override
  _ZoomHandleState createState() => _ZoomHandleState();
}

class _ZoomHandleState extends State<ZoomHandle> {
  @override
  Widget build(BuildContext context) {
    var state = ZoomProvider.of(context)!.state;
    return Row(
      children: [
        TextButton(
          onPressed: ZoomProvider.of(context)!.zoomOut,
          style: TextButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(12),
          ),
          child: Icon(
            Icons.remove,
            color: context.theme.hintColor,
          ),
        ),
        const SizedBox(width: 8),
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
        const SizedBox(width: 8),
        TextButton(
          onPressed: ZoomProvider.of(context)!.zoomIn,
          style: TextButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(12),
          ),
          child: Icon(
            Icons.add,
            color: context.theme.hintColor,
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: ZoomProvider.of(context)!.resetToNormal,
          style: TextButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(12),
          ),
          child: Icon(
            Icons.replay,
            color: context.theme.hintColor,
          ),
        ),
      ],
    );
  }
}
