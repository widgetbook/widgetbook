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
