import 'package:flutter/material.dart';

/// Same as `SettingToggle`, but the knob image is declared by this package
/// instead of the `assets` package, to tell package assets apart from local
/// ones.
class LocalAssetToggle extends StatelessWidget {
  const LocalAssetToggle({
    required this.title,
    required this.value,
    super.key,
  });

  final bool value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 16),
        SizedBox(
          width: 80,
          height: 40,
          child: Stack(
            children: [
              Positioned(
                left: value ? 40 : 0,
                top: 0,
                child: Image.asset(
                  'images/local_knob.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
