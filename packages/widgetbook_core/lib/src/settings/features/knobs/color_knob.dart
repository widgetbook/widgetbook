// TODO(jenshor): put this back in, when issue is resolved, https://github.com/widgetbook/widgetbook/issues/368
// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_property.dart';
import 'package:widgetbook_core/src/settings/widgets/widgets.dart';

enum ColorOptions {
  hex(name: 'HEX'),
  rgb(name: 'RGB (tbd)'),
  hsl(name: 'HSL (tbd)'),
  hsb(name: 'HSB (tbd)');

  const ColorOptions({
    required this.name,
  });

  final String name;
}

Color? colorTryParse(String value) {
  final colorValue = int.tryParse(value, radix: 16);
  if (colorValue == null) {
    return null;
  }

  if (colorValue < Colors.black.withAlpha(0).value ||
      colorValue > Colors.white.value) {
    return null;
  }

  return Color(colorValue);
}

String? colorErrorText(String value) {
  const errorText = 'Not a color';
  final color = colorTryParse(value);
  return color == null ? errorText : null;
}

class ColorKnob extends StatefulWidget {
  const ColorKnob({
    super.key,
    required this.name,
    this.description,
    required this.value,
    this.onChanged,
  });

  final String name;
  final String? description;
  final Color value;
  final void Function(Color value)? onChanged;

  @override
  State<ColorKnob> createState() => _ColorKnobState();
}

class _ColorKnobState extends State<ColorKnob> {
  late Color value;
  late String colorText;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    colorText = value.value.toRadixString(16);
    controller = TextEditingController(text: colorText);
  }

  Widget _buildColorPreview() {
    return Tooltip(
      message: 'A color picker is coming soon!',
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Color? parseColor() {
    return null;
  }

  void _callOnChanged(Color? newColor) {
    if (newColor == null) return;
    widget.onChanged?.call(newColor);
  }

  Widget _buildColorInputs() {
    return Row(
      children: [
        _buildColorPreview(),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                colorText = value;
                final newColor = colorTryParse(value);
                this.value = newColor ?? this.value;
                _callOnChanged(newColor);
              });
            },
            decoration: InputDecoration(
              errorText: colorErrorText(controller.text),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KnobProperty(
      name: widget.name,
      description: widget.description,
      value: widget.value,
      child: Row(
        children: [
          DropdownSetting(
            options: ColorOptions.values,
            optionValueBuilder: (option) => option.name,
            onSelected: (option) {},
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: _buildColorInputs(),
            ),
          ),
        ],
      ),
    );
  }
}
