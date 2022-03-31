import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/workbench/preview.dart';
import 'package:widgetbook/src/workbench/workbench_controls.dart';

class Workbench<CustomTheme> extends StatelessWidget {
  const Workbench({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PreviewProvider>().state;
    final useCase = state.selectedUseCase;
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
                : Preview<CustomTheme>(useCase: useCase),
          ),
        ),
      ],
    );
  }
}
