import 'package:flutter/material.dart';

import '../utils/ambiguate.dart';

class StyledScaffold extends StatelessWidget {
  const StyledScaffold({
    super.key,
    this.body,
  });

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ambiguate(WidgetsBinding.instance)!
          .focusManager
          .primaryFocus
          ?.unfocus,
      child: Scaffold(
        body: body,
      ),
    );
  }
}
