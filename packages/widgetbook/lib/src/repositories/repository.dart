import 'package:widgetbook/src/models/model.dart';

abstract class Repository<Item extends Model> {
  // Item operations
  String addItem(Item item);
  void setItem(Item item);
  Item getItem(String id);
  bool doesItemExist(String id);
  void updateItem(Item item);
  void deleteItem(Item item);

  // List operations
  Stream<List<Item>> getStreamOfItems();
  void closeStream();

  void deleteAll();
  void addAll(Iterable<Item> items);
}
