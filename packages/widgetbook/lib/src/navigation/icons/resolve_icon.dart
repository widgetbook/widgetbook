import 'package:flutter/material.dart';

import '../../../next.dart' as next;
import '../../../widgetbook.dart';
import '../nodes/nodes.dart';
import 'component_icon.dart';
import 'use_case_icon.dart';

Widget resolveIcon(WidgetbookNode node) {
  if (node is WidgetbookPackage) {
    return const Icon(Icons.inventory, size: 16);
  } else if (node is WidgetbookCategory) {
    return const Icon(Icons.auto_awesome_mosaic, size: 16);
  } else if (node is WidgetbookFolder) {
    return const Icon(Icons.folder, size: 16);
  } else if (node is WidgetbookComponent || node is WidgetbookLeafComponent) {
    return _NextWrapper(
      isNext: node is next.WidgetbookComponent,
      child: const ComponentIcon(),
    );
  } else if (node is WidgetbookUseCase) {
    return _NextWrapper(
      isNext: node is next.WidgetbookStory,
      child: const UseCaseIcon(),
    );
  } else {
    return const SizedBox();
  }
}

class _NextWrapper extends StatelessWidget {
  const _NextWrapper({
    required this.isNext,
    required this.child,
  });

  final bool isNext;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return !isNext
        ? child
        : Tooltip(
            message: 'Experimental',
            child: Badge(
              backgroundColor: Colors.red,
              alignment: AlignmentDirectional.centerStart,
              child: child,
            ),
          );
  }
}
