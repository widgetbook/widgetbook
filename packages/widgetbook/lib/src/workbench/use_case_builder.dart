import 'package:flutter/material.dart';

import '../navigation/navigation.dart';
import '../state/state.dart';

class UseCaseBuilder extends StatefulWidget {
  const UseCaseBuilder({
    super.key,
    required this.useCase,
  });

  final WidgetbookUseCase useCase;

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
      WidgetbookState.of(context).notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.useCase.builder(context);
  }
}
