import 'package:flutter/material.dart';

extension OrientationExtension on Orientation {
  String toShortString() {
    return toString().split('.').last;
  }
}
