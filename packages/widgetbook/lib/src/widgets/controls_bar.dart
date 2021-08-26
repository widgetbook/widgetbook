import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/constants/constants.dart';
import 'package:widgetbook/src/widgets/brand_handle.dart';
import 'package:widgetbook/src/widgets/device_bar.dart';
import 'package:widgetbook/src/cubit/zoom/zoom_cubit.dart';
import 'package:widgetbook/src/widgets/theme_handle.dart';
import 'package:widgetbook/src/widgets/zoom_handle.dart';

class ControlsBar extends StatelessWidget {
  const ControlsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: BlocBuilder<ZoomCubit, ZoomState>(
        builder: (context, state) {
          return SizedBox(
            height: Constants.controlBarHeight,
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                ZoomHandle(),
                SizedBox(
                  width: 40,
                ),
                ThemeHandle(),
                SizedBox(
                  width: 40,
                ),
                DeviceBar(),
                Expanded(
                  child: SizedBox(),
                ),
                BrandHandle(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
