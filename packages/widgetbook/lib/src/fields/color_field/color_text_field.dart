import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorTextField extends StatelessWidget {
  const ColorTextField({
    required this.value,
    required this.maxLength,
    required this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixText,
    this.labelText,
    super.key,
  });

  final String value;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final String? suffixText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        initialValue: value,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: labelText,
          counterText: '',
          prefixIcon: prefixIcon,
          suffixText: suffixText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
