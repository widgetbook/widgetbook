class GitError extends Error {
  GitError(this.message);

  final String message;

  @override
  String toString() => message;
}
