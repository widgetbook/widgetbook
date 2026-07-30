import 'package:flutter/material.dart';

/// A screen that reads [status] once in its [State], like screens that set up
/// controllers, animations or derived data for the state they were built with.
class BrewingScreen extends StatefulWidget {
  const BrewingScreen({
    super.key,
    required this.status,
  });

  final String status;

  @override
  State<BrewingScreen> createState() => _BrewingScreenState();
}

class _BrewingScreenState extends State<BrewingScreen> {
  late final String _status = widget.status;
  int _taps = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            Text(
              _status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Taps: $_taps',
              style: const TextStyle(color: Colors.white70, fontSize: 20),
            ),
            FilledButton(
              onPressed: () => setState(() => _taps++),
              child: const Text('Tap'),
            ),
          ],
        ),
      ),
    );
  }
}
