import 'package:test/test.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

void main() {
  group('$TreeService', () {
    final instance = TreeService()
      ..addFolderByImport('package:some_package/foo/bar/sample.dart');

    final instanceSrc = TreeService()
      ..addFolderByImport('package:some_package/src/foo/bar/sample.dart');

    test('TreeService skips src folder', () {
      expect(
        instance.folders.containsKey('foo'),
        equals(true),
      );

      expect(
        instanceSrc.folders.containsKey('src'),
        equals(false),
      );

      expect(
        instance.folders['foo']!.subFolders.containsKey('bar'),
        equals(true),
      );

      expect(
        instanceSrc.folders['foo']!.subFolders.containsKey('bar'),
        equals(true),
      );

      expect(
        instance.folders['foo']!.subFolders['bar']!.subFolders.isEmpty,
        equals(true),
      );

      expect(
        instanceSrc.folders['foo']!.subFolders['bar']!.subFolders.isEmpty,
        equals(true),
      );
    });

    instanceSrc.addFolderByImport('package:some_package/foo/other/widget.dart');

    test('TreeService merge same folder names', () {
      expect(
        instanceSrc.folders.containsKey('foo'),
        equals(true),
      );

      expect(
        instanceSrc.folders['foo']!.subFolders.length,
        equals(2),
      );

      expect(
        instanceSrc.folders['foo']!.subFolders.containsKey('bar'),
        equals(true),
      );

      expect(
        instanceSrc.folders['foo']!.subFolders.containsKey('other'),
        equals(true),
      );
    });
  });
}
