import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/canvas_state.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/model_helper.dart';

void main() {
  group(
    '$CanvasState',
    () {
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

          expectEqualHashCodes(instance1, instance2);
        },
      );
    },
  );
}
