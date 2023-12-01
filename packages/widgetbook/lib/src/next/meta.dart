class Meta<T> {
  Meta({
    String? name,
  }) : name = name == null ? T.toString() : name;

  final String name;
}
