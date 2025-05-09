import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        const CircleAvatar(backgroundImage: AssetImage('assets/avatar.png')),
        Text(name ?? 'Deleted User'),
      ],
    );
  }
}
