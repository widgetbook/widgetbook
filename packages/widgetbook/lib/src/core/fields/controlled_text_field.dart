import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Internal wrapper for [TextFormField] that uses a controller to preserve
/// focus and cursor position. Updates the text only when the value changes
/// externally and the field is not focused.
class ControlledTextField extends StatefulWidget {
  const ControlledTextField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.maxLines,
    this.keyboardType,
    this.inputFormatters,
    this.decoration,
  });

  final String initialValue;
  final void Function(String text) onChanged;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;

  @override
  State<ControlledTextField> createState() => _ControlledTextFieldState();
}

class _ControlledTextFieldState extends State<ControlledTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(ControlledTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue && !_focusNode.hasFocus) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: widget.decoration,
      onChanged: widget.onChanged,
    );
  }
}
