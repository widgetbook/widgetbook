import 'package:flutter/material.dart';

class SubSetting extends StatelessWidget {
  const SubSetting({
    super.key,
    required this.name,
    required this.child,
  });

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: Text(name)),
          const SizedBox(
            width: 24,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
