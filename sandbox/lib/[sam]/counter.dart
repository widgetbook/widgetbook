import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({
    super.key,
    this.initialValue = 0,
  });

  final int initialValue;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => setState(() => _count--),
          icon: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('$_count'),
        ),
        IconButton(
          onPressed: () => setState(() => _count++),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
