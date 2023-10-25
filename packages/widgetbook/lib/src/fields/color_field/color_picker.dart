import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_space.dart';
import 'hex_color_picker.dart';
import 'hsl_color_text_fields.dart';
import 'number_text_field.dart';
import 'rgb_color_picker.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    required this.colorSpace,
    required this.value,
    required this.defaultColor,
    required this.onChanged,
    super.key,
  });

  final ColorSpace colorSpace;
  final Color? value;
  final Color defaultColor;
  final ValueChanged<Color> onChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late ColorSpace initialColorSpace;
  late Color value;

  @override
  void initState() {
    super.initState();
    initialColorSpace = widget.colorSpace;
    value = widget.value ?? widget.defaultColor;
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
                color: widget.value ?? widget.defaultColor,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: DropdownButtonFormField<ColorSpace>(
                value: initialColorSpace,
                onChanged: (value) {
                  setState(() {
                    initialColorSpace = value ?? initialColorSpace;
                  });
                },
                items: ColorSpace.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            NumberTextField(
              value: '${((value.alpha / 255) * 100).round()}',
              maxLength: 3,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(
                  RegExp(r'^(0|[1-9][0-9]?|100)$'),
                  replacementString: '${((value.alpha / 255) * 100).round()}',
                ),
              ],
              suffixText: '%',
              onChanged: (value) {
                final alpha = ((int.tryParse(value) ?? 0) / 100 * 255).round();

                final newColor = Color.fromARGB(
                  alpha,
                  this.value.red,
                  this.value.green,
                  this.value.blue,
                );

                setState(() {
                  this.value = newColor;
                });
                widget.onChanged.call(newColor);
              },
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        if (initialColorSpace == ColorSpace.rgb) ...[
          RgbColorPicker(
            value: value,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                this.value = value;
              });
            },
          ),
        ] else if (initialColorSpace == ColorSpace.hsl) ...[
          HslColorPicker(
            value: value,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                this.value = value;
              });
            },
          ),
        ] else ...[
          HexColorPicker(
            value: value,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                this.value = value;
              });
            },
          ),
        ],
      ],
    );
  }
}
