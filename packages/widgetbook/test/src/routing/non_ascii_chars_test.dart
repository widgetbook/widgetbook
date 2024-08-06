import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$AppRouteConfig for non-ascii characters',
    () {
      testWidgets(
        'given query parameter in URL address, '
        'when query contains encoded special characters like: ` `, `,` etc., '
        'then this query string should decode',
        (tester) async {
          final state = await tester.pumpWidgetWithQueryParams(
            queryParams: {},
            builder: (context) => const SizedBox(),
          );
          final targetQuery = '{Test: %20 non-ascii}';
          final config = AppRouteConfig(
            uri: Uri.parse('/?knob=$targetQuery'),
          );

          state.updateFromRouteConfig(config);
          expect(
            state.queryParams['knob'].toString(),
            equals(
              targetQuery.replaceAll('%20', ' '),
            ),
          );
        },
      );

      testWidgets(
        'given non-ASCII characters in URL, '
        'then the application is open without decoding',
        (tester) async {
          const textKey = Key('knob-string-field');
          const keyOfData = 'Тест field';
          const valueOfData = 'значение';
          final state = await tester.pumpWidgetWithQueryParams(
            queryParams: {},
            builder: (context) {
              final text = context.knobs.string(
                label: keyOfData,
              );
              return Text(
                '$text',
                key: textKey,
              );
            },
          );

          await tester.pumpAndSettle();

          // Checking not initialized field
          final emptyTextWidget = await tester.widget<Text>(
            find.byKey(textKey),
          );

          expect(emptyTextWidget.data, '');

          // Simulate as opened URL via browser.
          state.updateFromRouteConfig(
            AppRouteConfig(
              uri: state.uri.replace(
                queryParameters: {
                  'knobs': '{$keyOfData:$valueOfData}',
                },
              ),
            ),
          );

          await tester.pumpAndSettle();

          final actualTextWidget = await tester.widget<Text>(
            find.byKey(textKey),
          );

          expect(actualTextWidget.data, valueOfData);
        },
      );

      testWidgets(
        'given non-ASCII characters and special charter (`,`) in URL, '
        'then captured error because URL\'s characters are invalid',
        (tester) async {
          final binding = TestWidgetsFlutterBinding.ensureInitialized();
          const textKey = Key('knob-string-field');
          const keyOfData = 'text field';
          const escapedCharacters = ',,,';
          const valueOfData = 'value ';

          final state = await tester.pumpWidgetWithQueryParams(
            queryParams: {},
            builder: (context) {
              final text = context.knobs.string(
                label: keyOfData,
              );
              return Text(
                '$text',
                key: textKey,
              );
            },
          );
          await tester.pumpAndSettle();

          // Checking for not initialized field
          final emptyTextWidget = await tester.widget<Text>(
            find.byKey(textKey),
          );
          expect(emptyTextWidget.data, '');

          // Simulate as opened URL via browser
          state.updateFromRouteConfig(
            AppRouteConfig(
              uri: state.uri.replace(
                queryParameters: {
                  'knobs': '{$keyOfData:$valueOfData$escapedCharacters}',
                },
              ),
            ),
          );

          await tester.pumpAndSettle();
          final error = binding.takeException();
          expect(error, isRangeError);
        },
      );
    },
  );
}
