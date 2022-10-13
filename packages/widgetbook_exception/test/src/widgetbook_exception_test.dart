import 'package:test/test.dart';
import 'package:widgetbook_exception/widgetbook_exception.dart';

class TestWidgetbookException extends WidgetbookException {
  TestWidgetbookException(super.message);
}

const message = 'Name is required';

void main() {
  late TestWidgetbookException sut;
  setUp(() {
    sut = TestWidgetbookException(message);
  });
  group('$WidgetbookException', () {
    test('accepts message', () {
      expect(sut.message, equals(message));
    });

    test('ensure overrides toString() returns the message', () {
      expect(sut.toString(), equals(message));
    });
  });
}
