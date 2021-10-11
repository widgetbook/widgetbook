import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/canvas_state.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group(
    '$CanvasState',
    () {
      // TODO this can be extracted into a function for less redundant code
      test(
        'the hashCodes of two instances with the same values are compared',
        () {
          const name = 'Name';
          final story = Story.child(
            name: name,
            child: Container(),
          );
          final instance1 = CanvasState(
            selectedStory: story,
          );

          final instance2 = CanvasState(
            selectedStory: story,
          );

          expect(
            instance1.hashCode == instance2.hashCode,
            equals(true),
          );
        },
      );
    },
  );
}
