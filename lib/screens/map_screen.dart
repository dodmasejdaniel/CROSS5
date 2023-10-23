import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../global_data.dart'; // Make sure you import this

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Item>('items').listenable(),
      builder: (context, Box<Item> box, _) {
        // Convert items to markers
        List<Marker> markers = box.values.map((item) {
          return Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(/* latitude */, /* longitude */),
            builder: (ctx) => Container(
              child: Icon(Icons.pin_drop),
            ),
          );
        }).toList();

        return Scaffold(
          appBar: AppBar(title: Text('Map')),
          body: FlutterMap(
            options: MapOptions(
              center: LatLng(51.5, -0.09),
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
