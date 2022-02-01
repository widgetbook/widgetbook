import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/tool/tool_provider.dart';
import 'package:widgetbook/src/tool/tool_state.dart';
import 'package:widgetbook/src/tool/toolbar.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/workbench/preview.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';
import 'package:widgetbook/src/workbench/workbench_controls.dart';
import 'package:provider/provider.dart';

class Workbench<CustomTheme> extends StatelessWidget {
  const Workbench({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = CanvasProvider.of(context)!.state;
    final useCase = state.selectedStory;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WorkbenchControls<CustomTheme>(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Radii.defaultRadius,
              color: context.colorScheme.surface,
            ),
            child: useCase == null
                ? Container()
                : Stack(
                    children: [
                      Preview<CustomTheme>(useCase: useCase),
                      const Positioned(
                        left: 24,
                        top: 24,
                        child: Toolbar(),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
