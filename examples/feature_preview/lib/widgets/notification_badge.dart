import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key, this.count});

  final int? count;

  @override
  Widget build(BuildContext context) {
    final label = count == null
        ? null
        : Text(count! < 100 ? count.toString() : '99+');
    return Badge(
      label: label,
      isLabelVisible: count != null && count! > 0,
      backgroundColor: Colors.amber,
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/avatar.png'),
      ),
    );
  }
}
