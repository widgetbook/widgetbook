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

  Future<String> _addItemAndEmitChangesToStream(Item item) async {
    String id = await _addItem(item);
    _emitChangesToStream();
    return id;
  }

  Future<String> _addItem(Item item) async {
    _memory.putIfAbsent(item.id, () => item);
    return item.id;
  }

  @override
  Future<String> addItem(Item item) async {
    return _addItemAndEmitChangesToStream(item);
  }

  Future<void> deleteItemAndEmitChangesToStream(Item item) async {
    await _deleteItem(item);
    _emitChangesToStream();
  }

  Future<void> _deleteItem(Item item) async {
    _memory.remove(item.id);
  }

  @override
  Future<void> deleteItem(Item item) async {
    deleteItemAndEmitChangesToStream(item);
  }

  @override
  Stream<List<Item>> getStreamOfItems() {
    return _streamController.stream;
  }

  @override
  Future<void> setItem(Item item) async {
    if (!_memory.containsKey(item.id)) {
      _addItemAndEmitChangesToStream(item);
    } else {
      updateItem(item);
    }
  }

  @override
  Future<void> updateItem(Item item) async {
    _memory[item.id] = item;
    _emitChangesToStream();
  }

  @override
  Future<Item> getItem(String id) async {
    return Future.value(_memory[id]);
  }
}
