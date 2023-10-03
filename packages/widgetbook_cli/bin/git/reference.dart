class Reference {
  Reference(this.sha, this.refName);

  /// Parses a [line] output from `git show-ref` output.
  /// The [line] can look as any one like these:
  ///
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
  final String refName;

  bool get isHEAD => refName == 'HEAD';
  bool get isTag => refName.startsWith('refs/tags/');
  bool get isHead => refName.startsWith('refs/heads/');
  bool get isRemote => refName.startsWith('refs/remotes/');
  bool get isBranch => isHead || isRemote;

  /// The [refName] without the `refs/*/` prefix.
  String get name {
    return refName.replaceFirst(
      RegExp(r'^refs/.+?/'),
      '',
    );
  }

  @override
  bool operator ==(covariant Reference other) {
    if (identical(this, other)) return true;

    return other.sha == sha && other.refName == refName;
  }

  @override
  int get hashCode => sha.hashCode ^ refName.hashCode;

  @override
  String toString() => '$sha $refName';
}
