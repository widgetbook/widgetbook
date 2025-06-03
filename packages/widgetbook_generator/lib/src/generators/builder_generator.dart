import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

class BuilderGenerator extends Generator {
  @override
  Future<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final buffer = StringBuffer();
    final useCases = <FunctionElement>[];

    // Collect all use cases in the library
    for (final element
        in library.annotatedWith(const TypeChecker.fromRuntime(UseCase))) {
      if (element.element is FunctionElement) {
        final function = element.element as FunctionElement;
        if (!function.isPrivate) {
          useCases.add(function);
        }
      }
    }

    if (useCases.isEmpty) return '';

    // Add part directive
    final sourceFile = library.element.source.uri.pathSegments.last;
    buffer.writeln("part of '$sourceFile';\n");

    // Process each use case
    for (final element in useCases) {
      final source = element.source;
      final sourceCode = source.contents.data;
      final annotationOffset = element.nameOffset;
      final annotationLength = element.nameLength;

      // Find the start of the function body
      final bodyStart =
          sourceCode.indexOf('{', annotationOffset + annotationLength);
      if (bodyStart == -1) continue;

      // Find the end of the function body by matching braces
      var braceCount = 1;
      var bodyEnd = bodyStart + 1;
      while (braceCount > 0 && bodyEnd < sourceCode.length) {
        if (sourceCode[bodyEnd] == '{') {
          braceCount++;
        } else if (sourceCode[bodyEnd] == '}') {
          braceCount--;
        }
        bodyEnd++;
      }

      if (braceCount != 0) continue;

      // Extract the function body
      var builderCode = sourceCode.substring(bodyStart, bodyEnd).trim();

      // Find all ComponentInfo widgets in the function body
      final componentRegex = RegExp(r'ComponentInfo\s*\([^)]*\)');
      final matches = componentRegex.allMatches(builderCode);

      for (final match in matches) {
        final componentInfo = match.group(0);
        if (componentInfo != null) {
          // Extract the component prop from the ComponentInfo
          final componentMatch =
              RegExp(r'component:\s*([^,)]+\))').firstMatch(componentInfo);
          if (componentMatch != null) {
            final componentCode = componentMatch.group(1)?.trim();
            if (componentCode != null) {
              // Create a new ComponentInfo with the extracted component code as codeSnippet
              final newComponentInfo = componentInfo.replaceAll(
                RegExp(r'\)$'),
                '), codeSnippet: """\n$componentCode\n"""',
              );
              // Replace only the current match
              builderCode = builderCode.substring(0, match.start) +
                  newComponentInfo +
                  builderCode.substring(match.end);
            }
          }
        }
      }

      // Add the builder function
      buffer.writeln('''
Widget ${element.name}Generated(BuildContext context) {
  $builderCode
}
''');
    }

    return buffer.toString();
  }
}
