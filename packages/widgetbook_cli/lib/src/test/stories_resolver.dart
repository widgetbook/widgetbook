import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as p;

import '../analyzer/collectors/component_collector.dart';
import '../core/cli_exception.dart';
import 'test_exit_codes.dart';

/// Resolves `--path` values to the names of the components their stories
/// files declare.
class StoriesResolver {
  const StoriesResolver(this.rootPath);

  /// The directory relative paths and globs are resolved against.
  final String rootPath;

  static const storiesExtension = '.stories.dart';

  /// Resolves each of the [paths] (a file, a folder or a glob) to its stories
  /// files, and each file to the names of the components it declares.
  Map<String, Set<String>> resolve(Iterable<String> paths) {
    final files = {
      for (final path in paths) ...findFiles(path),
    };

    return {
      for (final file in files) file: componentNames(file),
    };
  }

  /// The stories files at [path], relative to [rootPath].
  ///
  /// An existing path is never treated as a glob, as folder names such as
  /// `[shared]` would otherwise be read as glob syntax.
  List<String> findFiles(String path) {
    final absolute = p.normalize(p.join(rootPath, path));

    final List<String> files;
    if (File(absolute).existsSync()) {
      // An explicit file is kept as is, so a file that is not a stories file
      // is reported instead of silently matching nothing.
      files = [absolute];
    } else if (Directory(absolute).existsSync()) {
      files = Directory(absolute)
          .listSync(recursive: true)
          .whereType<File>()
          .map((file) => file.path)
          .where((file) => file.endsWith(storiesExtension))
          .toList();
    } else {
      files = Glob(path)
          .listSync(root: rootPath)
          .whereType<File>()
          .map((file) => p.normalize(file.path))
          .where((file) => file.endsWith(storiesExtension))
          .toList();
    }

    if (files.isEmpty) {
      throw CliException('$path not found', TestExitCodes.pathNotFound);
    }

    return (files.map((file) => p.relative(file, from: rootPath)).toList())
      ..sort();
  }

  /// The names of the components declared in [file], relative to [rootPath].
  ///
  /// The name of a component is the `name` of the file's `ComponentMeta`, or
  /// the widget of its `Meta` constructor tear-offs, as in the generated code.
  Set<String> componentNames(String file) {
    final unit = parseFile(
      path: p.normalize(p.absolute(rootPath, file)),
      featureSet: FeatureSet.latestLanguageVersion(),
    ).unit;

    final widgets = ComponentCollector();
    final componentMeta = _ComponentMetaNameVisitor();
    unit
      ..visitChildren(widgets)
      ..visitChildren(componentMeta);

    if (widgets.data.isEmpty) {
      throw CliException(
        '$file declares no Widgetbook component '
        '(expected a $storiesExtension file with const meta = Meta(...))',
        TestExitCodes.noComponent,
      );
    }

    if (componentMeta.hasName) {
      final name = componentMeta.name;
      if (name == null) {
        throw CliException(
          'The ComponentMeta name in $file is not a string literal, '
          'so its component cannot be resolved. Use --filter instead.',
          TestExitCodes.noComponent,
        );
      }

      return {name};
    }

    return widgets.data;
  }
}

/// Finds the `name` argument of a `ComponentMeta(...)` variable.
class _ComponentMetaNameVisitor extends RecursiveAstVisitor<void> {
  /// Whether a `ComponentMeta` sets a `name`.
  bool hasName = false;

  /// The `name` of the `ComponentMeta`, or `null` if it is not a literal.
  String? name;

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    final arguments = switch (node.initializer) {
      MethodInvocation(:final methodName, :final argumentList)
          when methodName.name == 'ComponentMeta' =>
        argumentList,
      InstanceCreationExpression(:final constructorName, :final argumentList)
          when constructorName.type.name.lexeme == 'ComponentMeta' =>
        argumentList,
      _ => null,
    };

    final nameArgument = arguments?.arguments
        .whereType<NamedArgument>()
        .where((argument) => argument.name.lexeme == 'name')
        .firstOrNull;

    if (nameArgument != null) {
      final expression = nameArgument.argumentExpression;
      hasName = expression is! NullLiteral;
      name = expression is SimpleStringLiteral ? expression.value : null;
    }

    super.visitVariableDeclaration(node);
  }
}
