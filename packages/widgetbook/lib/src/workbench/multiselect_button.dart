import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class MultiselectButton<CustomTheme> extends ConsumerWidget {
  const MultiselectButton({
    Key? key,
    required this.value,
  }) : super(key: key);

  final MultiRender value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = context.watch<WorkbenchProvider<CustomTheme>>();
    final state = provider.state;
    final currentValue = state.multiRender;
    final areEqual = value == currentValue;
    return WorkbenchButton.icon(
      onPressed: () {
        provider.changedMultiRender(value);
      },
      child: Icon(
        Icons.view_carousel,
        color: areEqual ? context.colorScheme.primary : context.theme.hintColor,
      ),
    );
  }
}
