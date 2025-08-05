import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class ComponentsBuilder implements Builder {
  static const outputFile = 'components.book.dart';

  static const ignoredLintRules = {
    'unused_import',
    'prefer_relative_imports',
    'directives_ordering',
  };

  static final headerParts = [
    '// coverage:ignore-file',
    '\n$defaultFileHeader',
    '// ignore_for_file: type=lint',
    '// ignore_for_file: ${ignoredLintRules.join(", ")}',
  ];

  @override
  final buildExtensions = const {
    r'$lib$': [outputFile],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final glob = Glob('**/*.stories.dart');
    final assets = buildStep.findAssets(glob);
    final components =
        await assets
            .asyncMap((asset) => buildStep.resolver.libraryFor(asset))
            .map((element) => LibraryReader(element))
            .map(
              (library) => library.allElements
                  .whereType<TopLevelVariableElement2>()
                  .firstWhere(
                    (element) => element.displayName.endsWith('Component'),
                  ),
            )
            .toList();

    final variable = declareFinal('components');
    final nodesValue = literalList(
      components
          .map(
            (e) => refer(
              e.displayName,
              e.firstFragment.libraryFragment.source.uri.toString().replaceAll(
                '.book.dart',
                '.dart',
              ),
            ),
          )
          .toList(),
      refer('WidgetbookNode', 'package:widgetbook/widgetbook.dart'),
    );

    final outputLibrary = Library(
      (b) {
        b.body.add(
          variable.assign(nodesValue).statement,
        );
      },
    );

    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
    );

    final outputAsset = AssetId(buildStep.inputId.package, 'lib/$outputFile');
    final content = '''
      ${headerParts.join('\n')}
      ${outputLibrary.accept(emitter)}
    ''';

    buildStep.writeAsString(outputAsset, content);
  }
}
