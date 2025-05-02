import 'package:flutter/material.dart';

import '../state/state.dart';

class UseCaseBuilder extends StatefulWidget {
  const UseCaseBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context) builder;

  @override
  State<UseCaseBuilder> createState() => _UseCaseBuilderState();
}

class _UseCaseBuilderState extends State<UseCaseBuilder> {
  @override
  void initState() {
    super.initState();

    // Notify that the use case finished building,
    // to rebuild the use case with all registered knobs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Use InheritedWidgetbookState.of instead of WidgetbookState.of to ensure
        // knobs work correctly even when nested in a Navigator (like with DeviceFrameAddon)
        InheritedWidgetbookState.of(context).knobs.lock();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
