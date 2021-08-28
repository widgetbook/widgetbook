import 'package:widgetbook/src/models/model.dart';

abstract class Repository<Item extends Model> {
  Future<String> addItem(Item item);
  Future<void> setItem(Item item);
  Future<Item> getItem(String id);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(Item item);
  Stream<List<Item>> getStreamOfItems();
}
