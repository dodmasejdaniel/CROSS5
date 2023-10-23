import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/item_model.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/about_screen.dart';


void main() async {
  print("Initializing Hive...");
  await Hive.initFlutter();
  print("Registering Hive Adapter...");
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<Item>('items');  // Change 'itemBox' to 'items'
  print("Starting MyApp...");
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building MyApp Widget");
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Assignment Project'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.map), text: 'Map'),
                Tab(icon: Icon(Icons.account_circle), text: 'Profile'),
                Tab(icon: Icon(Icons.info), text: 'About'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              MapScreen(),
              ProfileScreen(),
              AboutScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
