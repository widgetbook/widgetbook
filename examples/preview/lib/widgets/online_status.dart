import 'package:flutter/material.dart';

enum OnlineStatusType { online, offline, busy }

class OnlineStatusBadge extends StatelessWidget {
  const OnlineStatusBadge({super.key, this.status});

  final OnlineStatusType? status;

  @override
  Widget build(BuildContext context) {
    Map<OnlineStatusType?, Color> statusColors = {
      null: Colors.grey,
      OnlineStatusType.online: Colors.green,
      OnlineStatusType.offline: Colors.blueGrey,
      OnlineStatusType.busy: Colors.yellow,
    };
    return Badge(
      backgroundColor: statusColors[status],
      child: const CircleAvatar(
        backgroundImage: NetworkImage('assets/avatar.png'),
      ),
    );
  }
}
