import 'package:flutter/material.dart';

class GenericText<T> extends StatelessWidget {
  const GenericText({
    super.key,
    required this.value,
  });

  final T value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '[$T] $value',
    );
  }
}
