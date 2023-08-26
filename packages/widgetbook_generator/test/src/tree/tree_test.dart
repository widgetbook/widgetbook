import 'package:test/test.dart';
import 'package:widgetbook_generator/models/element_metadata.dart';
import 'package:widgetbook_generator/models/use_case_metadata.dart';
import 'package:widgetbook_generator/tree/tree.dart';

UseCaseMetadata createUseCase({
  required String uri,
  required String name,
}) {
  return UseCaseMetadata(
    designLink: null,
    importUri: '',
    filePath: '',
    functionName: '',
    name: 'Default',
    component: ElementMetadata(
      name: name,
      importUri: uri,
      filePath: '',
    ),
  );
}

void main() {
  group('$Tree', () {
    test('[getPathParts] for package path', () {
      final parts = Tree.getPathParts(
        'package:name/tree/tree.dart',
      );

      expect(parts, equals(['tree']));
    });

    test('[getPathParts] for package path with src', () {
      final parts = Tree.getPathParts(
        'package:name/src/tree/tree.dart',
      );

      expect(parts, equals(['tree']));
    });

    test('[build] creates the correct tree', () {
      final components = {
        'Alpha': 'package:foo/widgets/alpha/alpha.dart',
        'Beta': 'package:foo/widgets/beta/beta.dart',
      };

      final useCases = components.entries
          .map(
            (entry) => createUseCase(
              name: entry.key,
              uri: entry.value,
            ),
          )
          .toList();

      final root = Tree.build(useCases);

      expect(
        root.children.keys,
        equals(['widgets']),
      );

      expect(
        root.children['widgets']!.children.keys,
        equals(['alpha', 'beta']),
      );

      expect(
        root.children['widgets']!.children['alpha']!.children.keys,
        equals(['Alpha']),
      );

      expect(
        root.children['widgets']!.children['beta']!.children.keys,
        equals(['Beta']),
      );
    });
  });
}
