import 'package:flutter/material.dart';

class DateTimeText extends StatelessWidget {
  const DateTimeText({super.key, this.dateTime});

  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime == null
          ? 'You selected no date or time'
          : 'You selected ${dateTime!.toLocal()}',
    );
  }
}
