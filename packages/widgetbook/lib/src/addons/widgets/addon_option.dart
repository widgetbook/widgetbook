import 'package:flutter/material.dart';

class AddonOption extends StatelessWidget {
  const AddonOption({
    super.key,
    required this.child,
    required this.onTap,
    required this.isSelected,
  });

  final Widget child;
  final bool isSelected;
  final VoidCallback onTap;

  static const Color unselectedColor = Color(0xFF373737);
  static const Color selectedColor = Color(0xFF3174f6);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : unselectedColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          radius: 4,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: child,
          ),
        ),
      ),
    );
  }
}
