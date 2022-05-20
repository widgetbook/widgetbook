import 'package:flutter/material.dart';

class StyledScaffold extends StatelessWidget {
  const StyledScaffold({Key? key, this.body}) : super(key: key);

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: WidgetsBinding.instance.focusManager.primaryFocus?.unfocus,
      child: Scaffold(
        body: body,
      ),
    );
  }
}
