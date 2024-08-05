import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class UserPreferences extends GetxService {
  SharedPreferences? prefs;

  var isDarkMode = false.obs;
  var notificationsEnabled = true.obs;
  Future<UserPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs?.getBool('isDarkMode') ?? false;
    notificationsEnabled.value = prefs?.getBool('notificationsEnabled') ?? true;
    return this;
  }

  String get defaultCurrency => prefs?.getString('defaultCurrency') ?? 'PKR';

  set defaultCurrency(String value) {
    prefs?.setString('defaultCurrency', value);
  }

  // bool get notificationsEnabled => prefs?.getBool('notificationsEnabled') ?? true;
  //
  // set notificationsEnabled(bool value) {
  //   prefs?.setBool('notificationsEnabled', value);
  // }

  void setNotificationsEnabled(bool value) {
    notificationsEnabled.value = value;
    prefs?.setBool('notificationsEnabled', value);
  }


  double get salary => prefs?.getDouble('salary') ?? 0.0;

  set salary(double value) {
    prefs?.setDouble('salary', value);
  }

  void setDarkMode(bool value) {
    isDarkMode.value = value;
    prefs?.setBool('isDarkMode', value);
  }

}

