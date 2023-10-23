import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Version: 1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Developer Info:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('Name: John Doe'),
            SizedBox(height: 8),
            Text('Skills: Flutter, Dart'),
            SizedBox(height: 8),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile.jpg'), // Add your image in assets folder
            ),
          ],
        ),
      ),
    );
  }
}
