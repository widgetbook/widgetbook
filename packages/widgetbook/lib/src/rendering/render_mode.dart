import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'render_mode.freezed.dart';

/// Render mode allows users to customize how a widget is rendered
///
/// Possible options are
///   - The renderer defined by widgetbook (which is just a container)
///   - A renderer without any device size constraints
///   - The device_frame package
@freezed
class RenderMode with _$RenderMode {
  factory RenderMode({
    /// The name displayed as a tooltip
    required String name,

    /// Indicators whether this mode supports specific devices e.g. iPhone 11
    required bool allowsDevices,
  }) = _RenderMode;

  factory RenderMode.widgetbook() {
    return RenderMode(
      name: 'Widgetbook',
      allowsDevices: true,
    );
  }

  factory RenderMode.none() {
    return RenderMode(
      name: 'None',
      allowsDevices: false,
    );
  }

  factory RenderMode.devicePreview() {
    return RenderMode(
      name: 'Device Preview',
      allowsDevices: true,
    );
  }
}
