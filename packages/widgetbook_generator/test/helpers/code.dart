import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';
import 'package:widgetbook_generator/src/util/format.dart';

/// Formats output with dart formatter.
void useDartFormatter() {
  EqualsDart.format = (source) {
    return $format(source);
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
