import 'package:flutter/material.dart';

import '../state/state.dart';

class DocsPreview extends StatelessWidget {
  const DocsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final component = state.component;

    if (component == null || component.docs == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(component.name),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SelectableText(
          component.docs!,
        ),
      ),
    );
  }
}
