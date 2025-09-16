import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:test/test.dart';

/// Formats output with dart formatter.
void useDartFormatter() {
  final _formatter = DartFormatter(
    languageVersion: DartFormatter.latestShortStyleLanguageVersion,
  );

  EqualsDart.format = (source) {
    try {
      return _formatter.format(source);
    } on FormatException catch (_) {
      return _formatter.formatStatement(source);
    }
  };
}

/// Wraps an [expression] in a statement to make formatter work
Code wrapInStatement(Expression expression) {
  return declareFinal('test').assign(expression).statement;
}

void expectExpression(Expression actual, String expected) {
  useDartFormatter();
  expect(
    wrapInStatement(actual),
    equalsDart('final test = $expected;'),
  );
}
