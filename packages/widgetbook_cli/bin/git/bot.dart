// Code copied from
// https://github.com/kevmoo/bot.dart/commit/6badd135a5

void requireArgument(bool truth, String argName, [String? message]) {
  metaRequireArgumentNotNullOrEmpty(argName);
  if (!truth) {
    if (message == null || message.isEmpty) {
      message = 'value was invalid';
    }
    throw ArgumentError(message);
  }
}

void requireArgumentNotNullOrEmpty(String? argument, String argName) {
  metaRequireArgumentNotNullOrEmpty(argName);
  if (argument == null) {
    throw ArgumentError.notNull(argument);
  } else if (argument.isEmpty) {
    throw ArgumentError.value(argument, argName, 'cannot be an empty string');
  }
}

void requireArgumentContainsPattern(
    Pattern pattern, String argValue, String argName) {
  ArgumentError.checkNotNull(argValue, argName);
  if (!argValue.contains(pattern)) {
    throw ArgumentError.value(argValue, argName,
        'The value "$argValue" does not contain the pattern "$pattern"');
  }
}

void metaRequireArgumentNotNullOrEmpty(String argName) {
  if (argName.isEmpty) {
    throw const _InvalidOperationError(
      "That's just sad. Give me a good argName",
    );
  }
}

class _InvalidOperationError implements Exception {
  final String message;

  const _InvalidOperationError([this.message = '']);
}

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  const Tuple(this.item1, this.item2);

  @override
  bool operator ==(Object other) =>
      other is Tuple && item1 == other.item1 && item2 == other.item2;

  @override
  String toString() => '{item1: $item1, item2: $item2}';

  @override
  int get hashCode => item1.hashCode ^ 37 * item2.hashCode;

  dynamic toJson() => {'item1': item1, 'item2': item2};
}

class StringLineReader {
  final String source;

  int? _position = 0;

  StringLineReader(this.source) {
    ArgumentError.checkNotNull(source, 'source');
  }

  int? get position => _position;

  bool get eof => _position == null;

  String? readNextLine() => _peekOrReadNextLine(true);

  String? peekNextLine() => _peekOrReadNextLine(false);

  String? readToEnd() {
    if (_position == null) {
      return null;
    }
    final value = source.substring(position!, source.length);
    _position = null;
    return value;
  }

  String? _peekOrReadNextLine(bool updatePosition) {
    if (_position == null) {
      return null;
    }
    final nextLF = source.indexOf('\n', _position!);

    if (nextLF < 0) {
      // no more new lines, return what's left and set postion = null
      final value = source.substring(_position!, source.length);
      if (updatePosition) {
        _position = null;
      }
      return value;
    }

    // to handle Windows newlines, see if the value before nextLF is a Carriage
    final isWinNL = nextLF > 0 && source.substring(nextLF - 1, nextLF) == '\r';

    final value = isWinNL
        ? source.substring(_position!, nextLF - 1)
        : source.substring(_position!, nextLF);

    if (updatePosition) {
      _position = nextLF + 1;
    }

    return value;
  }
}
