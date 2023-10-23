import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:hive/hive.dart';
import '../models/item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample latitude and longitude for demonstration
    double latitude = 51.5074;  // London latitude
    double longitude = -0.1278;  // London longitude

    return ValueListenableBuilder(
      valueListenable: Hive.box<Item>('items').listenable(),
      builder: (context, Box<Item> box, _) {
        // Convert items to markers
        List<Marker> markers = box.values.map((item) {
  return Marker(
    width: 200.0,
    height: 200.0,
    point: LatLng(item.latitude, item.longitude),  // Use latitude and longitude from the item
    builder: (ctx) => Container(
      child: Icon(
        Icons.pin_drop,
        size: 100.0,
        color: Colors.red,
      ),
    ),
  );
}).toList();

        return Scaffold(
          appBar: AppBar(title: Text('Map')),
          body: FlutterMap(
            options: MapOptions(
              center: LatLng(latitude, longitude),  // Center the map here
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(markers: markers),
            ],
          ),
        );
      },
    );
  }
}
