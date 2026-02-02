import 'package:flutter/material.dart';

import '../docs/docs.dart';
import '../state/state.dart';

class DocsPreview extends StatelessWidget {
  const DocsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ComposerDocBlock(children: state.docs!),
        ),
      ),
    );
  }
}
