import 'dart:async';

import 'package:flutter/material.dart';

enum BrewPhase {
  brewing('Brewing'),
  diluting('Diluting'),
  brewingFinished('Brewing finished'),
  flushing('Flushing'),
  brewingAborted('Brewing aborted'),
  pistonRemoved('Piston removed');

  const BrewPhase(this.label);

  final String label;
}

/// Shows [warning] for two seconds before revealing its [phase], so that a lost
/// [State] is visible in the workbench: a remounted screen falls back to the
/// warning and its mount number goes up.
class BrewingScreen extends StatefulWidget {
  const BrewingScreen({
    super.key,
    required this.phase,
    this.warning = 'Watch out. Hot water',
  });

  final BrewPhase phase;
  final String warning;

  @override
  State<BrewingScreen> createState() => _BrewingScreenState();
}

class _BrewingScreenState extends State<BrewingScreen> {
  static int _mounts = 0;

  late final int _mount;
  Timer? _timer;
  bool _warning = true;

  @override
  void initState() {
    super.initState();

    _mount = ++_mounts;
    _timer = Timer(
      const Duration(seconds: 2),
      () {
        if (mounted) setState(() => _warning = false);
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        height: 320,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Text(
              _warning ? widget.warning : widget.phase.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'mount #$_mount',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
