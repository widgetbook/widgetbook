import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key, this.count});

  final int? count;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: count == null
          ? null
          : Text(count! < 100 ? count.toString() : '99+'),
      isLabelVisible: count != null && count! > 0,
      backgroundColor: Colors.amber,
      child: const Icon(Icons.notifications, size: 32),
    );
  }
}
