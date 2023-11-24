class ComponentMetadata<T> {
  ComponentMetadata({
    String? name,
  }) : name = name == null ? T.toString() : name;

  final String name;
}
