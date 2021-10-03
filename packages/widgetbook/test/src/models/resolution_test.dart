import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/resolution.dart';

void main() {
  group(
    '$Resolution',
    () {
      test('returns Size(200, 200) when logicalSize is called', () {
        var instance = Resolution.dimensions(
          height: 400,
          width: 400,
          scaleFactor: 2,
        );

        expect(
          instance.logicalSize,
          equals(
            Size(
              200,
              200,
            ),
          ),
        );
      });

      test(
        'returns true when instance is the same',
        () {
          var instance = Resolution.dimensions(
            height: 1,
            width: 1,
            scaleFactor: 1,
          );

          expect(
            instance == instance,
            equals(true),
          );
        },
      );

      group(
        'returns true when',
        () {
          test(
            'two instances with the same values are compared',
            () {
              var instance1 = Resolution.dimensions(
                height: 1,
                width: 1,
                scaleFactor: 1,
              );
              var instance2 = Resolution.dimensions(
                height: 1,
                width: 1,
                scaleFactor: 1,
              );

              expect(
                instance1 == instance2,
                equals(true),
              );
            },
          );

          test(
            'the hashCodes of two instances with the same values are compared',
            () {
              var instance1 = Resolution.dimensions(
                height: 1,
                width: 1,
                scaleFactor: 1,
              );
              var instance2 = Resolution.dimensions(
                height: 1,
                width: 1,
                scaleFactor: 1,
              );

              expect(
                instance1.hashCode == instance2.hashCode,
                equals(true),
              );
            },
          );
        },
      );
    },
  );
}
