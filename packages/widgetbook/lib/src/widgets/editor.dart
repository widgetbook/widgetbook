import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';

import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/widgets/controls_bar.dart';
import 'package:widgetbook/src/widgets/use_case_render.dart';

class Editor<CustomTheme> extends StatelessWidget {
  const Editor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ControlsBar<CustomTheme>(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Radii.defaultRadius,
              color: context.colorScheme.surface,
            ),
            child: UseCaseRender<CustomTheme>(),
          ),
        ),
      ],
    );
  }
}
