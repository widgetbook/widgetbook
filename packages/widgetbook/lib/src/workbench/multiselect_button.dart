import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class MultiselectButton<CustomTheme> extends ConsumerWidget {
  const MultiselectButton({
    Key? key,
    required this.value,
  }) : super(key: key);

  final MultiRender value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentValue =
        ref.watch(getWorkbenchProvider<CustomTheme>()).multiRender;
    final areEqual = value == currentValue;
    return TextButton(
      onPressed: () {
        ref
            .read(getWorkbenchProvider<CustomTheme>().notifier)
            .changedMultiRender(value);
      },
      style: TextButton.styleFrom(
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        minimumSize: Size.zero,
        padding: const EdgeInsets.all(12),
      ),
      child: Icon(
        Icons.view_carousel,
        color: areEqual ? context.colorScheme.primary : context.theme.hintColor,
      ),
    );
  }
}
