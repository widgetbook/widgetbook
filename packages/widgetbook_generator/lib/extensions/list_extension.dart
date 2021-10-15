extension ListExtensions<T> on List<T> {
  T? firstWhereOrDefault(bool Function(T) test) {
    var list = where((element) => test(element)).toList();

    if (list.isNotEmpty) {
      return list.first;
    }

    return null;
  }
}
