import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockBuildContext());
  });

  group(
    '$FieldCodec',
    () {
      const encodedGroup = '{first_field:false,second_field:2}';
      const decodedGroup = {
        'first_field': 'false',
        'second_field': '2',
      };

      test(
        'given a decoded query group with the field name, '
        'when [encodeQueryGroup] is called, '
        'then it returns the encoded value',
        () {
          final result = FieldCodec.encodeQueryGroup(decodedGroup);
          expect(result, equals(encodedGroup));
        },
      );

      test(
        'given an encoded query group, '
        'when [decodeQueryGroup] is called, '
        'then it returns the decoded value',
        () {
          final result = FieldCodec.decodeQueryGroup(encodedGroup);
          expect(result, equals(decodedGroup));
        },
      );
    },
  );
}
