import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

@internal
class NumberTextField extends StatelessWidget {
  const NumberTextField({
    super.key,
    required this.value,
    required this.maxLength,
    this.inputFormatters,
    this.suffixText,
    this.labelText,
    required this.onChanged,
  });

  NumberTextField.percentage({
    super.key,
    required this.value,
    this.labelText,
    required this.onChanged,
  }) : maxLength = 3,
       suffixText = '%',
       inputFormatters = [
         FilteringTextInputFormatter.digitsOnly,
         FilteringTextInputFormatter.allow(
           RegExp(r'^(0|[1-9][0-9]?|100)$'),
           replacementString: '$value',
         ),
       ];

  final int value;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final String? labelText;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: '$value',
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      onChanged: (value) {
        final newValue = int.tryParse(value);
        if (newValue == null) return;
        onChanged(newValue);
      },
      decoration: InputDecoration(
        hintText: 'Enter a number',
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
