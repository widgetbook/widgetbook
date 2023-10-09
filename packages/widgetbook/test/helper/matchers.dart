import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

Matcher throwsAssertion(String message) {
  return throwsA(
    allOf(
      isA<AssertionError>(),
      predicate<AssertionError>((err) => err.message == message),
    ),
  );
}

Matcher isGridPainterWith({
  required int dimension,
}) {
  return predicate<CustomPaint>(
    (widget) {
      final painter = widget.painter as GridPainter;
      return painter.dimension == dimension;
    },
    'CustomPaint with GridPainter having dimension: $dimension',
  );
}
