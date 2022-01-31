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
}
