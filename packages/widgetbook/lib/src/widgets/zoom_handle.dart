import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/cubit/zoom/zoom_cubit.dart';
import '../utils/extensions.dart';

class ZoomHandle extends StatelessWidget {
  const ZoomHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZoomCubit, ZoomState>(
      builder: (context, state) {
        return Row(
          children: [
            TextButton(
              onPressed: context.read<ZoomCubit>().zoomOut,
              style: TextButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90)),
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
                Text(
                  state.zoomLevel.toStringAsFixed(2),
                  style: context.theme.textTheme.subtitle2!.copyWith(
                    fontSize: 20,
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
              onPressed: context.read<ZoomCubit>().zoomIn,
              style: TextButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90)),
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
              onPressed: context.read<ZoomCubit>().resetToNormal,
              style: TextButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90)),
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
      },
    );
  }
}
