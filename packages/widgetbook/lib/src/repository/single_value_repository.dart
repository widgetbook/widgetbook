import 'dart:async';

class SingleValueRepository<Item> {
  SingleValueRepository()
      : _streamController = StreamController<Item?>.broadcast();

  Item? _item;
  final StreamController<Item?> _streamController;

  void _emitItemToStream() {
    _streamController.add(_item);
  }

  void setItem(Item? item) {
    _item = item;
    _emitItemToStream();
  }

  Item? getItem() {
    return _item;
  }

  void deleteItem() {
    _item = null;
    _emitItemToStream();
  }

  bool isSet() {
    return _item != null;
  }

  Stream<Item?> getStream() {
    return _streamController.stream;
  }
}
