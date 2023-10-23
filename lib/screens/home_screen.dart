import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/item_model.dart';
import '../services/hive_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Item> itemsBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    try {
      itemsBox = await Hive.openBox<Item>('items');
      setState(() {});
    } catch (e) {
      print("Error opening box: $e");
    }
  }

  void _addItem(String name, String location, String category) {
    final newItem = Item(name: name, location: location, category: category);
    itemsBox.add(newItem);
    setState(() {});
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: itemsBox.isOpen
          ? ListView.builder(
              itemCount: itemsBox.length,
              itemBuilder: (context, index) {
                final item = itemsBox.getAt(index)!;
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Location: ${item.location}, Category: ${item.category}'),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showForm(context);
        },
      ),
    );
  }

  void _showForm(BuildContext context) {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    String? selectedCategory;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  hint: Text("Select Category"),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: ["Food", "Place", "Other"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addItem(
                      nameController.text,
                      locationController.text,
                      selectedCategory ?? "Unknown",
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

