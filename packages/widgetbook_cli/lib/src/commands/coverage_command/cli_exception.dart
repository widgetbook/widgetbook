class CliException implements Exception {
  CliException(this.message, this.exitCode);

  final String message;
  final int exitCode;

  @override
  String toString() {
    return message;
  }
}
