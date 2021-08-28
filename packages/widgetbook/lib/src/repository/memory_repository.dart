import 'dart:async';

import 'dart:collection';

import 'package:widgetbook/src/models/model.dart';
import 'package:widgetbook/src/repository/repository.dart';

class MemoryRepository<Item extends Model> extends Repository<Item> {
  final Map<String, Item> _memory;
  StreamController<List<Item>> _streamController;

  MemoryRepository({Map<String, Item>? initialConfiguration})
      : this._memory = initialConfiguration ?? HashMap(),
        this._streamController = StreamController<List<Item>>.broadcast() {
    this._streamController.onListen = _emitChangesToStream;
  }

  void _emitChangesToStream() {
    _streamController.add(_memory.values.toList());
  }

  String _addItemAndEmitChangesToStream(Item item) {
    String id = _addItem(item);
    _emitChangesToStream();
    return id;
  }

  String _addItem(Item item) {
    _memory.putIfAbsent(item.id, () => item);
    return item.id;
  }

  @override
  String addItem(Item item) {
    return _addItemAndEmitChangesToStream(item);
  }

  void deleteItemAndEmitChangesToStream(Item item) {
    _deleteItem(item);
    _emitChangesToStream();
  }

  void _deleteItem(Item item) {
    _memory.remove(item.id);
  }

  @override
  void deleteItem(Item item) {
    deleteItemAndEmitChangesToStream(item);
  }

  @override
  Stream<List<Item>> getStreamOfItems() {
    return _streamController.stream;
  }

  @override
  void setItem(Item item) {
    if (!_memory.containsKey(item.id)) {
      _addItemAndEmitChangesToStream(item);
    } else {
      updateItem(item);
    }
  }

  @override
  void updateItem(Item item) {
    _memory[item.id] = item;
    _emitChangesToStream();
  }

  @override
  bool doesItemExist(String id) {
    return _memory.containsKey(id);
  }

  @override
  Item getItem(String id) {
    return _memory[id]!;
  }

  @override
  void deleteAll() {
    print('DeleteAll');
    _memory.clear();
    _emitChangesToStream();
  }

  @override
  void addAll(Iterable<Item> items) {
    print('AddAll');
    var map = HashMap<String, Item>.fromIterable(
      items,
      key: (k) => k.id,
      value: (v) => v,
    );
    _memory.addAll(map);
    _emitChangesToStream();
  }
}
