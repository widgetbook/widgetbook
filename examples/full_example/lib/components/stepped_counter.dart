import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final counterKey = GlobalKey();

@widgetbook.UseCase(
  name: 'Default',
  type: SteppedCounter,
)
Widget steppedCounterUseCase(BuildContext context) {
  return SteppedCounter(
    key: counterKey, // To preserve state
    step: context.knobs.int.slider(
      label: 'Step',
      initialValue: 1,
    ),
  );
}

class SteppedCounter extends StatefulWidget {
  const SteppedCounter({
    super.key,
    required this.step,
  });

  final int step;

  @override
  State<SteppedCounter> createState() => _SteppedCounterState();
}

class _SteppedCounterState extends State<SteppedCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Badge.count(
      count: widget.step,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => setState(() => count -= widget.step),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => count += widget.step),
            ),
          ],
        ),
      ),
    );
  }
}
