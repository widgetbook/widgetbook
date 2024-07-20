@Tags(['browser'])

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/routing/routing.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$AppRouteConfig with non-ascii symbols',
    () {
      testWidgets(
        'encoding for unsafe ASCII characters with a "%"',
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
        'opening with non-encoded url',
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
              return Text('$text', key: textKey);
            },
          );
          await tester.pumpAndSettle();

          // Checking not initialized field
          {
            final textWidget = await tester.widget<Text>(find.byKey(textKey));
            expect(textWidget.data, '');
          }
          // Simulate as opened via broweser by url.
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

          {
            final textWidget = await tester.widget<Text>(find.byKey(textKey));
            expect(textWidget.data, valueOfData);
          }
        },
      );

      testWidgets(
        'opening with non-encoded url with special characters: `,`, `{`, `}`',
        (tester) async {
          const textKey = Key('knob-string-field');
          const keyOfData = 'Тест field';
          const escapedCharacters = ',.{}';
          const valueOfData = 'значение ';
          final state = await tester.pumpWidgetWithQueryParams(
            queryParams: {},
            builder: (context) {
              final text = context.knobs.string(
                label: keyOfData,
              );
              return Text('$text', key: textKey);
            },
          );
          await tester.pumpAndSettle();

          // Checking not initialized field
          {
            final textWidget = await tester.widget<Text>(find.byKey(textKey));
            expect(textWidget.data, '');
          }
          // Simulate as opened via broweser by url.
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

          {
            final textWidget = await tester.widget<Text>(find.byKey(textKey));
            expect(textWidget.data, valueOfData);
          }
        },
      );
    },
  );
}
