class Context {
  const Context({
    required this.name,
    required this.userName,
    required this.repoName,
    this.providerSha,
  });

  final String name;
  final String? userName;
  final String? repoName;
  final String? providerSha;

  @override
  bool operator ==(covariant Context other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.userName == userName &&
        other.repoName == repoName &&
        other.providerSha == providerSha;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        userName.hashCode ^
        repoName.hashCode ^
        providerSha.hashCode;
  }
}
