import 'package:hive/hive.dart';
import '../models/item_model.dart';

class HiveService {
  var box = Hive.box('items');

  // To fetch all items
  List<Item> fetchAllItems() {
    return box.values.toList().cast<Item>();
  }

  // To add a new item
  void addItem(Item item) {
    box.add(item);
  }
}
