import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    final initials = name != null && name!.isNotEmpty
        ? name!.split(' ').map((w) => w.isNotEmpty ? w[0] : '').join()
        : '?';
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        CircleAvatar(child: Text(initials.toUpperCase())),
        Text(name ?? 'Deleted User'),
      ],
    );
  }
}
