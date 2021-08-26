import 'package:flutter/material.dart';

class Ingredients extends StatelessWidget {
  final List<String> ingredients;
  final bool centerText;
  const Ingredients({
    Key? key,
    required this.ingredients,
    this.centerText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ingredients.join(', '),
      textAlign: centerText ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        color: Color(
          0xFF707175,
        ),
      ),
    );
  }
}
