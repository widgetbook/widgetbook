import 'package:flutter/material.dart';

import 'color_space.dart';
import 'hex_color_picker.dart';
import 'hsl_color_picker.dart';
import 'number_text_field.dart';
import 'rgb_color_picker.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    required this.value,
    super.key,
    required this.colorSpace,
    required this.onChanged,
  });

  final Color value;
  final ColorSpace colorSpace;
  final ValueChanged<Color> onChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color value;
  late ColorSpace colorSpace;

  @override
  void initState() {
    super.initState();
    colorSpace = widget.colorSpace;
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.square,
                color: value,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            DropdownMenu<ColorSpace>(
              width: 100,
              initialSelection: colorSpace,
              onSelected: (value) {
                setState(() => colorSpace = value!);
              },
              dropdownMenuEntries: ColorSpace.values
                  .map(
                    (value) => DropdownMenuEntry(
                      value: value,
                      label: value.name.toUpperCase(),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: NumberTextField.percentage(
                value: ((value.alpha / 255) * 100).round(),
                onChanged: (value) {
                  final alpha = (value / 100 * 255).round();

                  final newColor = Color.fromARGB(
                    alpha,
                    this.value.red,
                    this.value.green,
                    this.value.blue,
                  );

                  setState(() => this.value = newColor);
                  widget.onChanged.call(newColor);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        if (colorSpace == ColorSpace.rgb) ...[
          RgbColorPicker(
            value: value,
            onChanged: (value) {
              setState(() => this.value = value);
              widget.onChanged(value);
            },
          ),
        ] else if (colorSpace == ColorSpace.hsl) ...[
          HslColorPicker(
            value: value,
            onChanged: (value) {
              setState(() => this.value = value);
              widget.onChanged(value);
            },
          ),
        ] else ...[
          HexColorPicker(
            value: value,
            onChanged: (value) {
              setState(() => this.value = value);
              widget.onChanged(value);
            },
          ),
        ],
      ],
    );
  }
}
