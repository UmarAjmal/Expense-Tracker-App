import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/user_preferences.dart';
// import '../controlers/user_preferences.dart';
 // Import your user preferences controller

class SettingsScreen extends StatelessWidget {
  final UserPreferences userPreferences = Get.find<UserPreferences>();

  static var routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF5004F),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Theme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Obx(() {
              return SwitchListTile(
                title: Text('Dark Mode'),
                value: userPreferences.isDarkMode.value,
                onChanged: (value) {
                  userPreferences.setDarkMode(value);
                },
              );
            }),
            SizedBox(height: 20),
            Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Obx(() {
              return SwitchListTile(
                title: Text('Enable Notifications'),
                value: userPreferences.notificationsEnabled.value,
                onChanged: (value) {
                  userPreferences.setNotificationsEnabled(value);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
