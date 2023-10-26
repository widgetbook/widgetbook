import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    super.key,
    required this.value,
    required this.maxLength,
    required this.onChanged,
    this.inputFormatters,
    this.suffixText,
    this.labelText,
  });

  final String value;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        suffixText: suffixText,
        suffixStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
