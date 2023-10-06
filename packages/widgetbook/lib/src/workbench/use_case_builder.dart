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
  Key? _builderKey;
  int? _knobsLength;

  @override
  void initState() {
    super.initState();

    // Notify that the use case finished building,
    // to rebuild the use case with all registered knobs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final knobs = WidgetbookState.of(context).knobs..lock();
        _knobsLength = knobs.length;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _builderKey = null;
    final state = WidgetbookState.of(context);
    state.knobs.checkIns.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final expectedCheckIns = _knobsLength;
      if (!mounted || expectedCheckIns == null) {
        return;
      }

      if (state.knobs.checkIns.length < expectedCheckIns) {
        // not all knobs have checked in after the most recent build
        // it's likely that some widget is stateful -> force rebuild now!
        // use case may opt-out of this behavior by using a GlobalKey
        setState(() => _builderKey = ValueKey(state.uri));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: widget.builder,
      key: _builderKey,
    );
  }
}
