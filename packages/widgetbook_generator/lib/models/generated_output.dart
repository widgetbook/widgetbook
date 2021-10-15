import 'dart:convert';

import 'package:source_gen/source_gen.dart';

class GeneratedOutput {
  final String output;
  final Generator generator;
  final dynamic error;
  final StackTrace? stackTrace;

  bool get isError => error != null;

  GeneratedOutput(
    this.generator,
    this.output,
  )   : error = null,
        stackTrace = null,
        assert(output.isNotEmpty),
        assert(output.length == output.trim().length);

  GeneratedOutput.fromError(
    this.generator,
    this.error,
    this.stackTrace,
  ) : output = _outputFromError(error);

  @override
  String toString() {
    final output = generator.toString();
    if (output.endsWith('Generator')) {
      return output;
    }
    return 'Generator: $output';
  }
}

String _outputFromError(
  Object error,
) {
  final buffer = StringBuffer();

  _commentWithHeader(
    _errorHeader,
    error.toString(),
    buffer,
  );

  if (error is InvalidGenerationSourceError && error.todo.isNotEmpty) {
    _commentWithHeader(
      _todoHeader,
      error.todo,
      buffer,
    );
  }

  return buffer.toString();
}

void _commentWithHeader(
  String header,
  String content,
  StringSink buffer,
) {
  final lines = const LineSplitter().convert(content);

  buffer
    ..writeAll(
      [
        _commentPrefix,
        header,
        lines.first,
      ],
    )
    ..writeln();

  final blankPrefix = ''.padLeft(header.length, ' ');
  for (var i = 1; i < lines.length; i++) {
    buffer
      ..writeAll(
        [
          _commentPrefix,
          blankPrefix,
          lines[i],
        ],
      )
      ..writeln();
  }
}

const _commentPrefix = '// ';
const _errorHeader = 'Error: ';
const _todoHeader = 'TODO: ';
