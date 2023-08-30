import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_playground/main.dart';

void main() {
  testWidgets('Just run test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WidgetbookApp());
  });
}
