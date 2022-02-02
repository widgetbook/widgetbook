import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/translate/translate_provider.dart';
import 'package:widgetbook/src/translate/translate_state.dart';

void main() {
  const offset = Offset(1, 1);
  group(
    '$TranslateProvider',
    () {
      test(
        'defaults to $Offset.zero',
        () {
          final provider = TranslateProvider();
          expect(
            provider.state,
            equals(
              TranslateState(
                offset: Offset.zero,
              ),
            ),
          );
        },
      );

      test(
        'updateOffset sets value',
        () {
          final provider = TranslateProvider()..updateOffset(offset);
          expect(
            provider.state,
            equals(
              TranslateState(
                offset: offset,
              ),
            ),
          );
        },
      );

      test(
        'updateRelativeOffset adds $offset',
        () {
          final provider = TranslateProvider(
            state: TranslateState(
              offset: offset,
            ),
          )..updateRelativeOffset(offset);
          expect(
            provider.state,
            equals(
              TranslateState(
                offset: const Offset(2, 2),
              ),
            ),
          );
        },
      );

      test(
        'resetOffset resets $Offset to $Offset.zero',
        () {
          final provider = TranslateProvider(
            state: TranslateState(
              offset: offset,
            ),
          )..resetOffset();
          expect(
            provider.state,
            equals(
              TranslateState(
                offset: Offset.zero,
              ),
            ),
          );
        },
      );
    },
  );
}
