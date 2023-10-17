import 'package:test/test.dart';
import 'package:widgetbook_generator/src/generators/use_case_generator.dart';

void main() {
  group('$UseCaseGenerator', () {
    test('[getNavPath] for package path', () {
      final navPath = UseCaseGenerator.getNavPath(
        'package:name/tree/tree.dart',
      );

      expect(navPath, equals('tree'));
    });

    test('[getNavPath] for package path with src', () {
      final navPath = UseCaseGenerator.getNavPath(
        'package:name/src/tree/tree.dart',
      );

      expect(navPath, equals('tree'));
    });
  });
}
