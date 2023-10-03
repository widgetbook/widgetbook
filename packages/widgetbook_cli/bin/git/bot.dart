// Code copied from
// https://github.com/kevmoo/bot.dart/commit/6badd135a5

const shaRegexPattern = '[a-f0-9]{40}';

final headerRegExp = RegExp(r'^([a-z]+) (.+)$');

// ignore: prefer_interpolation_to_compose_strings
final _shaRegEx = RegExp(r'^' + shaRegexPattern + r'$');

bool isValidSha(String value) => _shaRegEx.hasMatch(value);

void requireArgumentValidSha1(String value, String argName) {
  if (argName.isEmpty) {
    throw Exception(
      "That's just sad. Give me a good argName",
    );
  }

  if (value.isEmpty) {
    throw ArgumentError.value(value, argName, 'cannot be an empty string');
  }

  if (!isValidSha(value)) {
    final message = 'Not a valid SHA1 value: $value';
    throw ArgumentError.value(value, argName, message);
  }
}

class StringLineReader {
  StringLineReader(this.source) {
    ArgumentError.checkNotNull(source, 'source');
  }

  final String source;

  int? _position = 0;

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
