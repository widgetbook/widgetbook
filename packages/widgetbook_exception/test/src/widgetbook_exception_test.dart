// Copyright (c) 2022, Jens Horstmann
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:test/test.dart';
import 'package:widgetbook_exception/widgetbook_exception.dart';

void main() {
  group('$WidgetbookException', () {
    group('Test $WidgetbookException', () {
      test('ensure $WidgetbookException can be instantiated', () {
        const message = 'widgetbook_exception message';
        const exception = WidgetbookException(message);
        expect(exception.message, equals(message));
      });

      test('ensure overrides toString() returns a message', () {
        const message = 'widgetbook_exception  message';
        const exception = WidgetbookException(message);
        expect(exception.toString(), equals(message));
      });
    });
  });
}
