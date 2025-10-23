import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'color_picker_dialog.dart';
import 'color_space.dart';
import 'number_text_field.dart';
import 'opaque_color.dart';
import 'opaque_color_picker.dart';

@internal
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
  Timer? _debounce;
  late int alpha;
  late ColorSpace colorSpace;
  late OpaqueColor opaqueColor;

  /// Key used to reset the state of the color space pickers when the color changes.
  late Key pickerKey = ObjectKey(widget.value);

  @override
  void initState() {
    super.initState();
    alpha = (widget.value.a * 255).toInt();
    colorSpace = widget.colorSpace;
    opaqueColor = OpaqueColor.fromColor(widget.value);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onChange(int newAlpha, OpaqueColor newColor, {bool debounce = false}) {
    setState(() {
      alpha = newAlpha;
      opaqueColor = newColor;
    });

    _debounce?.cancel();
    if (!debounce) {
      widget.onChanged.call(newColor.toColor().withAlpha(newAlpha));
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      widget.onChanged.call(newColor.toColor().withAlpha(newAlpha));
    });
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
            Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    final box = context.findRenderObject() as RenderBox?;
                    final position = box!.localToGlobal(Offset.zero) & box.size;

                    showDialog<Color>(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (context) {
                        return Stack(
                          children: [
                            PositionedPopUp(
                              anchor: Offset(position.left - 28, position.top),
                              child: ColorPickerDialog(
                                initialColor: opaqueColor.toColor().withAlpha(
                                  alpha,
                                ),
                                onChanged: (color) {
                                  pickerKey = ObjectKey(color);
                                  opaqueColor = OpaqueColor.fromColor(color);
                                  alpha = color.a * 255 ~/ 1;
                                  onChange(alpha, opaqueColor, debounce: true);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(46),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.square,
                      color: opaqueColor.toColor().withAlpha(alpha),
                    ),
                  ),
                );
              },
            ),
            DropdownMenu<ColorSpace>(
              width: 100,
              initialSelection: colorSpace,
              onSelected: (value) {
                setState(() => colorSpace = value!);
              },
              dropdownMenuEntries:
                  ColorSpace.values
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
                key: pickerKey,
                value: ((alpha / 255) * 100).toInt(),
                onChanged: (value) {
                  final newValue = (value / 100 * 255).round();
                  setState(() => this.alpha = newValue);
                  onChange(newValue, opaqueColor);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        OpaqueColorPicker.fromColorSpace(
          colorSpace,
          key: pickerKey,
          value: opaqueColor,
          onChanged: (value) {
            setState(() => this.opaqueColor = value);
            onChange(alpha, value);
          },
        ),
      ],
    );
  }
}

@internal
class PositionedPopUp extends StatefulWidget {
  const PositionedPopUp({
    super.key,
    required this.anchor,
    required this.child,
  });

  final Offset anchor;
  final Widget child;

  @override
  State<PositionedPopUp> createState() => _PositionedPopUpState();
}

class _PositionedPopUpState extends State<PositionedPopUp> {
  final key = GlobalKey();
  Offset? offset;
  Size? popupSize;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final size = renderBox.size;
        final screen = MediaQuery.sizeOf(context);

        var dx = widget.anchor.dx - size.width;
        if (dx < 0) dx = 0.0;

        var dy = widget.anchor.dy;
        if (dy + size.height > screen.height) {
          dy = screen.height - size.height;
        }

        setState(() {
          offset = Offset(dx, dy);
          popupSize = size;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (offset == null) {
      // Initial offscreen position for measuring
      return Positioned(
        key: key,
        left: -1000,
        top: -1000,
        child: widget.child,
      );
    }

    return Positioned(
      left: offset!.dx,
      top: offset!.dy,
      child: widget.child,
    );
  }
}
