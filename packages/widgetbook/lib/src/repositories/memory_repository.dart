import 'dart:async';

import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:widgetbook/src/models/model.dart';
import 'package:widgetbook/src/repositories/repository.dart';

class MemoryRepository<Item extends Model> extends Repository<Item> {
  MemoryRepository({Map<String, Item>? initialConfiguration})
      : memory = initialConfiguration ?? HashMap(),
        _streamController = StreamController<List<Item>>.broadcast() {
    _streamController.onListen = _emitChangesToStream;
  }

  @internal
  final Map<String, Item> memory;

  final StreamController<List<Item>> _streamController;

  void _emitChangesToStream() {
    _streamController.add(memory.values.toList());
  }

  String _addItemAndEmitChangesToStream(Item item) {
    final id = _addItem(item);
    _emitChangesToStream();
    return id;
  }

  String _addItem(Item item) {
    memory.putIfAbsent(item.id, () => item);
    return item.id;
  }

  @override
  String addItem(Item item) {
    return _addItemAndEmitChangesToStream(item);
  }

  void _deleteItemAndEmitChangesToStream(Item item) {
    _deleteItem(item);
    _emitChangesToStream();
  }

  void _deleteItem(Item item) {
    memory.remove(item.id);
  }

  @override
  void deleteItem(Item item) {
    _deleteItemAndEmitChangesToStream(item);
  }

  @override
  Stream<List<Item>> getStreamOfItems() {
    return _streamController.stream;
  }

  @override
  void setItem(Item item) {
    if (!memory.containsKey(item.id)) {
      _addItemAndEmitChangesToStream(item);
    } else {
      updateItem(item);
    }
  }

  @override
  void updateItem(Item item) {
    memory[item.id] = item;
    _emitChangesToStream();
  }

  @override
  bool doesItemExist(String id) {
    return memory.containsKey(id);
  }

  @override
  Item getItem(String id) {
    return memory[id]!;
  }

  @override
  void deleteAll() {
    memory.clear();
    _emitChangesToStream();
  }

  @override
  void addAll(Iterable<Item> items) {
    final map = HashMap<String, Item>.fromIterable(
      items,
      key: (dynamic k) => k.id as String,
      value: (dynamic v) => v as Item,
    );
    memory.addAll(map);
    _emitChangesToStream();
  }

  @override
  Future<void> closeStream() {
    return _streamController.close();
  }
}
