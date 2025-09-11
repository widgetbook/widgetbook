/// Class representation of the refs from `git show-ref` output.
class Reference {
  const Reference(this.sha, this.fullName);

  /// Parses a [line] output from `git show-ref` output.
  /// The [line] can look as any one like these:
  ///
  /// - `832e76a9899f560a90ffd62ae2ce83bbeff58f54 HEAD`
  /// - `832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/heads/main`
  /// - `832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/remotes/origin/main`
  /// - `3521017556c5de4159da4615a39fa4d5d2c279b5 refs/tags/v0.99.9c`
  factory Reference.parse(String line) {
    final parts = line.trim().split(' ');

    return Reference(parts[0], parts[1]);
  }

  final String sha;
  final String fullName;

  /// Returns the [fullName] without the `refs/*/` prefix.
  static String nameOf(String fullName) {
    return fullName.replaceFirst(
      RegExp(r'^refs/.+?/'),
      '',
    );
  }

  bool get isHEAD => fullName == 'HEAD';
  bool get isTag => fullName.startsWith('refs/tags/');
  bool get isHead => fullName.startsWith('refs/heads/');
  bool get isRemote => fullName.startsWith('refs/remotes/');
  bool get isBranch => isHead || isRemote;

  /// The [fullName] without the `refs/*/` prefix.
  String get name => nameOf(fullName);

  @override
  bool operator ==(covariant Reference other) {
    if (identical(this, other)) return true;

    return other.sha == sha && other.fullName == fullName;
  }

  @override
  int get hashCode => sha.hashCode ^ fullName.hashCode;

  @override
  String toString() => '$sha $fullName';
}
