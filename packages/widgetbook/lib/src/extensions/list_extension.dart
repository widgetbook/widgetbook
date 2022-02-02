extension ListExtension<T> on List<T> {
  T getNext(T? currentItem) {
    final selectedItem = currentItem ?? last;
    final index = indexOf(selectedItem);
    final nextIndex = (index + 1) % length;
    return this[nextIndex];
  }

  T getPrevious(T? currentItem) {
    final selectedItem = currentItem ?? last;
    final index = indexOf(selectedItem);
    var previousIndex = index - 1;
    if (previousIndex < 0) {
      previousIndex = length - 1;
    }
    return this[previousIndex];
  }

  /// On hot reload the hash code of a list changes even if the contents of the
  /// list remain the same. Therefore, if the hash code of a list is used for
  /// checking if a widget has been hot reloaded, the widget always rebuilds.
  ///
  /// The [hashCodeOfItems] method solves this problem by only using the hash
  /// codes of the elements for building the hash code of the list.
  int get hashCodeOfItems {
    var currentHash = 0;

    for (final item in this) {
      currentHash ^= item.hashCode;
    }

    return currentHash;
  }
}
