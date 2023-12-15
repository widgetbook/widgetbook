import 'package:flutter/material.dart';

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
