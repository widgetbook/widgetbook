import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';
import 'package:widgetbook_generator/code/resolver_allocator.dart';

void main() {
  group('$ResolverAllocator', () {
    test('converts asset imports', () {
      final allocator = ResolverAllocator('foo/widgetbook.dart');

      allocator.allocate(
        refer(
          'testUseCase',
          'asset:foo/test/bar/qux.dart',
        ),
      );

      expect(
        allocator.imports.map((import) => import.url),
        equals(['../test/bar/qux.dart']),
      );
    });

    test('keeps package imports as-is', () {
      final allocator = ResolverAllocator('foo/widgetbook.dart');

      allocator.allocate(
        refer(
          'defaultUseCase',
          'package:foo/bar/qux.dart',
        ),
      );

      expect(
        allocator.imports.map((import) => import.url),
        equals(['package:foo/bar/qux.dart']),
      );
    });
  });
}
