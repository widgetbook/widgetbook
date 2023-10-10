import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class ZoomControlField extends Field<double> {
  ZoomControlField({
    required super.name,
    required super.initialValue,
    super.onChanged,
  }) : super(
          type: FieldType.custom, // Assuming you have a custom FieldType
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => double.tryParse(param ?? '1.0') ?? 1.0,
          ),
        );

  @override
  Widget toWidget(BuildContext context, String group, double? value) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.zoom_out),
          tooltip: 'Zoom Out',
          onPressed: () => _updateZoom(context, group, value, -0.1),
        ),
        Text(
          '${(value ?? 1.0).toStringAsFixed(1)}x',
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.zoom_in),
          tooltip: 'Zoom In',
          onPressed: () => _updateZoom(context, group, value, 0.1),
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Reset Zoom',
          onPressed: () => updateField(context, group, 1.0),
        ),
      ],
    );
  }

  void _updateZoom(
    BuildContext context,
    String group,
    double? value,
    double delta,
  ) {
    // limit the zoom between 0.5 (50%) and 3.0 (300%).
    final newValue = (value ?? 1.0) + delta;
    if (newValue >= 0.5 && newValue <= 3.0) {
      updateField(context, group, newValue);
    }
  }
}
