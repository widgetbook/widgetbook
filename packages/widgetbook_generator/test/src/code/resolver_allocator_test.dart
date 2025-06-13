import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

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

    test('prefixes imports with a namespace', () {
      final allocator = ResolverAllocator('foo/widgetbook.dart');

      allocator.allocate(refer('testUseCase', 'package:foo/bar/qux.dart'));
      allocator.allocate(
        refer('otherTestUseCase', 'package:foo/bar/other/qux.dart'),
      );
      allocator.allocate(
        refer('someOtherTestUseCase', 'package:foo/bar/some/other/qux.dart'),
      );

      expect(
        allocator.imports.map((import) => import.url),
        equals([
          'package:foo/bar/qux.dart',
          'package:foo/bar/other/qux.dart',
          'package:foo/bar/some/other/qux.dart',
        ]),
      );

      expect(
        allocator.imports.map((import) => import.as),
        equals(
          ['_foo_bar_qux', '_foo_bar_other_qux', '_foo_bar_some_other_qux'],
        ),
      );
    });

    test('prefixed imports with common basename', () {
      final allocator = ResolverAllocator('foo/widgetbook.dart');

      // import 'package:foo/widgets.dart';
      // import 'package:bar/widgets.dart';
      allocator.allocate(refer('widgets', 'package:foo/widgets.dart'));
      allocator.allocate(refer('widgets', 'package:bar/widgets.dart'));

      expect(
        allocator.imports.map((import) => import.url),
        equals(['package:foo/widgets.dart', 'package:bar/widgets.dart']),
      );

      expect(
        allocator.imports.map((import) => import.as),
        equals(['_foo_widgets', '_bar_widgets']),
      );
    });

    test('prefix should be the package name when a barrel export is used', () {
      final allocator = ResolverAllocator('foo/widgetbook.dart');

      allocator.allocate(refer('widgets', 'package:foo/foo.dart'));

      expect(
        allocator.imports.map((import) => import.as),
        equals(['_foo']),
      );
    });
  });
}
