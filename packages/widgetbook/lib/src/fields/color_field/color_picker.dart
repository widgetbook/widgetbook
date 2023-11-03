import 'package:flutter/material.dart';

import 'color_space.dart';
import 'number_text_field.dart';
import 'opaque_color.dart';
import 'opaque_color_picker.dart';

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
  late int opacity;
  late ColorSpace colorSpace;
  late OpaqueColor opaqueColor;

  @override
  void initState() {
    super.initState();
    opacity = widget.value.alpha ~/ 2.55;
    colorSpace = widget.colorSpace;
    opaqueColor = OpaqueColor.fromColor(widget.value);
  }

  void onChange(int newOpacity, OpaqueColor newColor) {
    setState(() {
      opacity = newOpacity;
      opaqueColor = newColor;
    });

    widget.onChanged.call(
      newColor.toColor().withOpacity(newOpacity / 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.square,
                color: opaqueColor.toColor(),
              ),
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
            SizedBox(
              width: 80,
              child: NumberTextField.percentage(
                value: opacity,
                onChanged: (value) {
                  setState(() => this.opacity = value);
                  onChange(value, opaqueColor);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        OpaqueColorPicker.fromColorSpace(
          colorSpace,
          value: opaqueColor,
          onChanged: (value) {
            setState(() => this.opaqueColor = value);
            onChange(opacity, value);
          },
        ),
      ],
    );
  }
}
