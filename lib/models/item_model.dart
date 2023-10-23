import 'package:hive/hive.dart';

part 'item_model.g.dart';



@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String location;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final double latitude;

  @HiveField(4)
  final double longitude;

  Item({required this.name, required this.location, required this.category, required this.latitude, required this.longitude});
}
