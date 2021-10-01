import 'dart:async';

import 'package:meta/meta.dart';

class ValueRepository<Item> {
  ValueRepository({
    this.item,
  }) : _streamController = StreamController<Item?>.broadcast() {
    _emitItemToStream();
  }

  @internal
  Item? item;
  final StreamController<Item?> _streamController;

  void _emitItemToStream() {
    _streamController.add(item);
  }

  void setItem(Item? value) {
    item = value;
    _emitItemToStream();
  }

  Item? getItem() {
    return item;
  }

  void deleteItem() {
    item = null;
    _emitItemToStream();
  }

  bool isSet() {
    return item != null;
  }

  Stream<Item?> getStream() {
    return _streamController.stream;
  }

  Future<void> closeStream() {
    return _streamController.close();
  }
}
