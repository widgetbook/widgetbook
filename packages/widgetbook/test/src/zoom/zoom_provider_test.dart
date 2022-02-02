import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/zoom/zoom_provider.dart';
import 'package:widgetbook/src/zoom/zoom_state.dart';

void main() {
  group(
    '$ZoomProvider',
    () {
      test(
        'default zoom is 1',
        () {
          final provider = ZoomProvider();
          expect(
            provider.state,
            ZoomState(zoomLevel: 1),
          );
        },
      );

      test(
        '.zoomIn increases zoom to 1.25',
        () {
          final provider = ZoomProvider()..zoomIn();
          expect(
            provider.state,
            ZoomState(zoomLevel: 1.25),
          );
        },
      );

      test(
        '.zoomIn increases zoom to 0.75',
        () {
          final provider = ZoomProvider()..zoomOut();
          expect(
            provider.state,
            ZoomState(zoomLevel: 0.75),
          );
        },
      );

      test(
        '.setScale(2) sets zoom to 2',
        () {
          final provider = ZoomProvider()..setScale(2);
          expect(
            provider.state,
            ZoomState(zoomLevel: 2),
          );
        },
      );

      test(
        '.resetToNormal sets zoom to 1',
        () {
          final provider = ZoomProvider(state: ZoomState(zoomLevel: 2))
            ..resetToNormal();
          expect(
            provider.state,
            ZoomState(),
          );
        },
      );
    },
  );
}
