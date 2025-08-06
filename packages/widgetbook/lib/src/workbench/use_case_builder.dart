import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../state/state.dart';

/// The [UseCaseBuilder] is a widget that builds the use case in the context
/// of the [WidgetbookState]. It is responsible for locking the knobs
/// after the use case has been built.
@internal
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
        WidgetbookState.of(context).knobs.lock();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
