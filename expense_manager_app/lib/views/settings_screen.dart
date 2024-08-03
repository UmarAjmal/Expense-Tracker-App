import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/user_preferences.dart';

class SettingsScreen extends StatelessWidget {
  final UserPreferences userPreferences = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Default Currency'),
              onChanged: (value) {
                userPreferences.defaultCurrency = value;
              },
              controller: TextEditingController(
                text: userPreferences.defaultCurrency,
              ),
            ),
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: userPreferences.notificationsEnabled,
              onChanged: (value) {
                userPreferences.notificationsEnabled = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}



