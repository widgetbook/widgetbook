/// Extension to make accessing list elements simple
extension ListExtensions<T> on List<T> {
  /// a firstWhere implementation that allows for a nullable return type when
  /// the lists elements are non-nullable
  T? firstWhereOrDefault(bool Function(T) test) {
    final list = where((element) => test(element)).toList();

    if (list.isNotEmpty) {
      return list.first;
    }

    return null;
  }
}
