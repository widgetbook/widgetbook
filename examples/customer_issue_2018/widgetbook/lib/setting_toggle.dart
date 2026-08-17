import 'package:flutter/material.dart';

/// The customer's widget from widgetbook#2018.
///
/// The knob image comes from the `assets` package, which is a dependency of
/// both the app and this Widgetbook.
class SettingToggle extends StatelessWidget {
  const SettingToggle({
    required this.title,
    required this.toggleFunction,
    required this.value,
    super.key,
    this.disabled = false,
  });

  final void Function() toggleFunction;
  final bool value;
  final String title;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: disabled ? null : toggleFunction,
          child: SizedBox(
            width: 80,
            height: 40,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  left: value ? 40 : 0,
                  top: 0,
                  child: Image.asset(
                    'images/knob.png',
                    height: 40,
                    width: 40,
                    package: 'assets',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
