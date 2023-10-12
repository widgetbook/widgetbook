
import 'package:flutter/material.dart';

import '../field.dart';
import '../field_codec.dart';
import '../field_type.dart';
import 'color_converter.dart';
import 'color_space.dart';
import 'hex_color_text_fields.dart';
import 'hsl_color_text_fields.dart';
import 'rgba_color_text_fields.dart';

export 'color_space.dart';

/// [Field] that builds [ColorsFieldWidget] for [Color] values.
///
/// The [ColorField] uses the [ColorFieldCodec] to convert the [Color] value to a
/// hex string and vice versa.
///
/// The [ColorField] uses the [ColorSpace] to determine which format the color is.
class ColorField extends Field<Color> {
  ColorField({
    required super.name,
    super.initialValue = defaultColor,
    this.initialColorSpace = ColorSpace.hex,
    super.onChanged,
  }) : super(
          type: FieldType.color,
          codec: FieldCodec(
            toParam: (color) => color.value.toRadixString(16),
            toValue: (param) {
              if (param == null) return null;
              if (param == '0') return Colors.transparent;
              if (param.length == 6) param = 'ff' + param;
              return Color(
                int.parse(
                  param,
                  radix: 16,
                ),
              );
            },
          ),
        );

  ColorSpace initialColorSpace;

  static const defaultColor = Colors.white;

  @override
  Widget toWidget(BuildContext context, String group, Color? value) {
    return ColorsFieldWidget(
      name: name,
      colorSpace: initialColorSpace,
      value: value,
      initialValue: initialValue,
      defaultColor: defaultColor,
      paramValue: codec.toParam(value ?? initialValue ?? defaultColor),
      onChanged: (value) {
        updateField(
          context,
          group,
          codec.toValue(value as String?) ?? initialValue ?? defaultColor,
        );
      },
    );
  }
}

class ColorsFieldWidget extends StatefulWidget {
  const ColorsFieldWidget({
    required this.name,
    required this.colorSpace,
    required this.paramValue,
    required this.initialValue,
    required this.value,
    required this.defaultColor,
    required this.onChanged,
    super.key,
  });

  final ColorSpace colorSpace;
  final String name;
  final Color? value;
  final Color? initialValue;
  final Color defaultColor;
  final String paramValue;
  final ValueChanged<dynamic> onChanged;

  @override
  State<ColorsFieldWidget> createState() => _ColorsFieldWidgetState();
}

class _ColorsFieldWidgetState extends State<ColorsFieldWidget> {
  late ColorSpace initialColorSpace;
  late dynamic colorValue;
  final ColorsConverter converter = ColorsConverter();

  @override
  void initState() {
    super.initState();
    initialColorSpace = widget.colorSpace;
    colorValue = converter.getValueByColorSpace(
      colorSpace: initialColorSpace,
      value: widget.paramValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (initialColorSpace == ColorSpace.rgba) ...[
          RgbaColorTextFields(
            colorValue: [...colorValue as List<String>],
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                colorValue = converter.getValueByColorSpace(
                  colorSpace: initialColorSpace,
                  value: widget.paramValue,
                );
              });
            },
            converter: converter,
          )
        ] else if (initialColorSpace == ColorSpace.hsl) ...[
          HslColorTextFields(
            colorValue: [...colorValue as List<String>],
            paramValue: widget.paramValue,
            onChanged: (hexValue, value) {
              if (hexValue != null) {
                widget.onChanged(hexValue);
              }
              setState(() {
                colorValue = [...value];
              });
            },
            converter: converter,
          )
        ] else ...[
          HexColorTextFields(
            colorValue: colorValue as String,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                colorValue = converter.getValueByColorSpace(
                  colorSpace: initialColorSpace,
                  value: widget.paramValue,
                );
              });
            },
            converter: converter,
          )
        ],
        const SizedBox(
          height: 16,
        ),
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
                color: widget.value ?? widget.initialValue ?? widget.defaultColor,
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
                    colorValue = converter.getValueByColorSpace(
                      colorSpace: initialColorSpace,
                      value: widget.paramValue,
                    );
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
          ],
        ),
      ],
    );
  }
}