import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class ComponentsBuilder implements Builder {
  const ComponentsBuilder({
    required this.header,
  });

  static const outputFile = 'components.book.dart';
  final String header;

  @override
  final buildExtensions = const {
    r'$lib$': [outputFile],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final glob = Glob('**/*.stories.dart');
    final assets = buildStep.findAssets(glob);
    final components = await assets
        .asyncMap((asset) => buildStep.resolver.libraryFor(asset))
        .map((element) => LibraryReader(element))
        .map(
          (library) => library.allElements
              .whereType<TopLevelVariableElement>()
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
      refer('Component', 'package:widgetbook/widgetbook.dart'),
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

    final formatter = DartFormatter(
      languageVersion: DartFormatter.latestShortStyleLanguageVersion,
    );

    final output = formatter.format(
      outputLibrary.accept(emitter).toString(),
    );

    final outputAsset = AssetId(buildStep.inputId.package, 'lib/$outputFile');
    final content = '$header\n$output';

    buildStep.writeAsString(outputAsset, content);
  }
}
