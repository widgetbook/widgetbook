import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

enum ColorSpace {
  rgba,
  hex,
  hsl,
}

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
        if(param == null) return null;
        if(param == '0') return Colors.transparent;
        if(param.length == 6) param = 'ff' + param;
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
      colorSpace: initialColorSpace,
      value: value,
      initialValue: initialValue,
      defaultColor: defaultColor,
      paramValue: codec.toParam(value ?? initialValue ?? defaultColor),
      onChanged: (value){
        updateField(
          context,
          group,
          codec.toValue(value as String?) ?? initialValue ?? defaultColor,
        );
      },
    );
  }  
  
}

class ColorsFieldWidget extends StatefulWidget{

  const ColorsFieldWidget({
    required this.colorSpace,
    required this.paramValue,
    required this.initialValue,
    required this.value,
    required this.defaultColor,
    required this.onChanged,
    super.key,
  });

  final ColorSpace colorSpace;
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

  @override
  void initState() {
    super.initState();
    initialColorSpace = widget.colorSpace;
    colorValue = getValueByColorSpace(widget.paramValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if(initialColorSpace == ColorSpace.rgba)...[
              ColorTextField(
                key: const Key('colorFieldRgbaRed'),
                value: colorValue[1] as String, 
                maxLength: 3, 
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'), 
                    replacementString: colorValue[1] as String,
                  )
                ],
                labelText: 'R',
                onChanged: (value) {
                  widget.onChanged(
                    calculateValueByColorSpace<List<String>>(
                      value: [
                        '${colorValue[0]}',
                        value,
                        '${colorValue[2]}',
                        '${colorValue[3]}',
                      ],
                    ),
                  );
                  setState(() {
                    colorValue = getValueByColorSpace(widget.paramValue);
                  });
                },
              ),
              ColorTextField(
                key: const Key('colorFieldRgbaGreen'),
                value: colorValue[2] as String, 
                maxLength: 3, 
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'), 
                    replacementString: colorValue[2] as String,
                  )
                ],
                labelText: 'G',
                onChanged: (value) {
                  widget.onChanged(
                    calculateValueByColorSpace<List<String>>(
                      value: [
                        '${colorValue[0]}',
                        '${colorValue[1]}',
                        value,
                        '${colorValue[3]}',
                      ],
                    ),
                  );
                  setState(() {
                    colorValue = getValueByColorSpace(widget.paramValue);
                  });
                },
              ),
              ColorTextField(
                key: const Key('colorFieldRgbaBlue'),
                value: colorValue[3] as String, 
                maxLength: 3, 
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'), 
                    replacementString: colorValue[3] as String,
                  )
                ],
                labelText: 'B',
                onChanged: (value) {
                  widget.onChanged(
                    calculateValueByColorSpace<List<String>>(
                      value: [
                        '${colorValue[0]}',
                        '${colorValue[1]}',
                        '${colorValue[2]}',
                        value,
                      ],
                    ),
                  );
                  setState(() {
                    colorValue = getValueByColorSpace(widget.paramValue);
                  });
                },
              ),
              ColorTextField(
                key: const Key('colorFieldRgbaAlpha'),
                value: colorValue[0] as String, 
                maxLength: 3, 
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(?:1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$'), 
                    replacementString: colorValue[0] as String,
                  )
                ],
                labelText: 'A',
                onChanged: (value) {
                  widget.onChanged(
                    calculateValueByColorSpace<List<String>>(
                      value: [
                        value,
                        '${colorValue[1]}',
                        '${colorValue[2]}',
                        '${colorValue[3]}',
                      ],
                    ),
                  );
                  setState(() {
                    colorValue = getValueByColorSpace(widget.paramValue);
                  });
                },
              ),
            ]else if(initialColorSpace == ColorSpace.hsl)...[
              ColorTextField(
                key: const Key('colorFieldHslHue'),
                value: colorValue[0] as String, 
                maxLength: 3, 
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(?:[1-9]\d?|[12]\d{2}|3[0-5]\d)$'), 
                    replacementString: colorValue[0] as String,
                  )
                ],
                labelText: 'H',
                onChanged: (value) {
                  final initialValue = calculateValueByColorSpace(
                    value: getValueByColorSpace(widget.paramValue)
                  );
                  final updateValue = calculateValueByColorSpace<List<String>>(
                    value: [
                      value,
                      '${colorValue[1]}',
                      '${colorValue[2]}',
                    ],
                  );
                  if(initialValue != updateValue){
                    widget.onChanged(updateValue);
                  }
                  setState(() {
                    colorValue = [
                      value,
                      '${colorValue[1]}',
                      '${colorValue[2]}',
                    ];
                  });
                },
              ),
              ColorTextField(
                key: const Key('colorFieldHslSaturation'),
                value: colorValue[1] as String, 
                maxLength: 3, 
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(0|[1-9][0-9]?|100)$'), 
                    replacementString: colorValue[1] as String,
                  )
                ],
                labelText: 'S',
                suffixText: '%',
                onChanged: (value) {
                  final initialValue = calculateValueByColorSpace(
                    value: getValueByColorSpace(widget.paramValue)
                  );
                  final updateValue = calculateValueByColorSpace<List<String>>(
                    value: [
                      '${colorValue[0]}',
                      value,
                      '${colorValue[2]}',
                    ],
                  );
                  if(initialValue != updateValue){
                    widget.onChanged(updateValue);
                  }
                  setState(() {
                    colorValue = [
                      '${colorValue[0]}',
                      value,
                      '${colorValue[2]}',
                    ];
                  });
                },
              ),
              ColorTextField(
                key: const Key('colorFieldHslLightness'),
                value: colorValue[2] as String, 
                maxLength: 3, 
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(0|[1-9][0-9]?|100)$'), 
                    replacementString: colorValue[2] as String,
                  )
                ],
                labelText: 'L',
                suffixText: '%',
                onChanged: (value) {
                  final initialValue = calculateValueByColorSpace(
                    value: getValueByColorSpace(widget.paramValue)
                  );
                  final updateValue = calculateValueByColorSpace<List<String>>(
                    value: [
                      '${colorValue[0]}',
                      '${colorValue[1]}',
                      value,
                    ],
                  );
                  if(initialValue != updateValue){
                    widget.onChanged(updateValue);
                  }
                  setState(() {
                    colorValue = [
                      '${colorValue[0]}',
                      '${colorValue[1]}',
                      value,
                    ];
                  });
                },
              ),
            ]else...[
              ColorTextField(
                key: const Key('colorFieldHex'),
                value: colorValue as String,
                maxLength: 8,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9a-fA-F]{0,8}$'), 
                    replacementString: colorValue as String,
                  ),
                ],
                onChanged: (value) {
                  widget.onChanged(calculateValueByColorSpace<String>(value: value));
                },
              ),
            ],
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            Icon(
              Icons.square, 
              color: widget.value ?? widget.initialValue ?? widget.defaultColor,
            ),
            const SizedBox(width: 8,),
            Flexible(
              child: DropdownButtonFormField<ColorSpace>(
                value: initialColorSpace,
                onChanged: (value) {
                  setState(() {
                    initialColorSpace = value ?? initialColorSpace;
                    colorValue = getValueByColorSpace(widget.paramValue);
                  });
                },
                items: ColorSpace.values.map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value.name),
                  ),
                ).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String calculateValueByColorSpace<T>({
    T? value,
  }){
    switch(initialColorSpace){
      case ColorSpace.hex:
        return value as String;
      case ColorSpace.rgba:
        return rgbaToHex(value as List<String>);
      default:
        return hslToHex(value as List<String>);
    }
  }

  dynamic getValueByColorSpace(String hex){
    switch(initialColorSpace){
      case ColorSpace.hex:
        return hex;
      case ColorSpace.rgba:
        return hexToRgba(hex);
      default:
        return hexToHsl(hex);
    }
  }

  List<String> hexToRgba(String hex){
    // Add the alpha value if it's not there
    if(hex.length == 1){
      hex = ''.padLeft(8, hex);
    }
    // Add the alpha value if it's not there
    if(hex.length == 6){
      hex = 'ff' + hex;
    }
    // Get the int value of the hex string
    int intColor = int.tryParse('0x$hex') ?? 0;
    int alpha = (intColor >> 24) & 0xFF;
    int red = (intColor >> 16) & 0xFF;
    int green = (intColor >> 8) & 0xFF;
    int blue = intColor & 0xFF;
    
    return ['$alpha', '$red', '$green', '$blue'];
  }

  String rgbaToHex(List<String> rgba){
    int alpha = int.tryParse(rgba[0]) ?? 0;
    int red = int.tryParse(rgba[1]) ?? 0;
    int green = int.tryParse(rgba[2]) ?? 0;
    int blue = int.tryParse(rgba[3]) ?? 0;
    return '${alpha.toRadixString(16).padLeft(2, '0')}${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';
  } 

  List<String> hexToHsl(String hex){
    // Start from rgba values because it's easier to convert to hsl
    List<int> rgbaValues = hexToRgba(hex).map((e) => int.tryParse(e) ?? 0).toList();

    // get all the values and divide them by 255 to get a value between 0 and 1
    double r = rgbaValues[1] / 255;
    double g = rgbaValues[2] / 255;
    double b = rgbaValues[3] / 255;

    // get the max and min value of the rgb values
    double max = [r, g, b].reduce((value, element) => value > element ? value : element);
    double min = [r, g, b].reduce((value, element) => value < element ? value : element);

    double h = 0;
    double s = 0;
    double l = (max + min) / 2;
    if(max == min){
      h = s = 0;
    }else{
      // get the difference between the max and min value
      double difference = max - min;
      // calculate the saturation
      s = l > 0.5 ? difference / (2 - max - min) : difference / (max + min);
      // calculate the hue
      if(max == r){
        h = (g - b) / difference + (g < b ? 6 : 0);
      }else if(max == g){
        h = (b - r) / difference + 2;
      }else if(max == b){
        h = (r - g) / difference + 4;
      }
      h /= 6;
    }
    
    return ['${(h * 360).toInt()}', '${(s * 100).toInt()}', '${(l * 100).toInt()}'];
  }

  // Create a function that got a list of String that represent the HSL values and return a hex value
  String hslToHex(List<String> hsl){
    double h = double.tryParse(hsl[0]) ?? 0;
    double s = double.tryParse(hsl[1]) ?? 0;
    double l = double.tryParse(hsl[2]) ?? 0;

    h /= 360;
    s /= 100;
    l /= 100;

    double r = 0;
    double g = 0;
    double b = 0;
    if(s == 0){
      r = g = b = l;
    }else{
      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;
      r = hueToRgb(p, q, h + 1 / 3);
      g = hueToRgb(p, q, h);
      b = hueToRgb(p, q, h - 1 / 3);
    }
    return rgbaToHex(['255', '${(r * 255).toInt()}', '${(g * 255).toInt()}', '${(b * 255).toInt()}']);
  }

  double hueToRgb(double p, double q, double t){
    if(t < 0) t += 1;
    if(t > 1) t -= 1;
    if(t < 1 / 6) return p + (q - p) * 6 * t;
    if(t < 1 / 2) return q;
    if(t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }

}


class ColorTextField extends StatelessWidget {
  const ColorTextField({
    required this.value,
    required this.maxLength,
    required this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixText,
    this.labelText,
    super.key
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