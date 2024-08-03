// import 'package:expense_tracker_app/views/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'controlers/expense_controller.dart';
// import 'controlers/expense_controller.dart';
// import 'models/expense.dart';
// import 'services/user_preferences.dart';
// import 'views/home_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(ExpenseAdapter());
//   await Hive.openBox<Expense>('expenses');
//   await Get.putAsync(() async => UserPreferences().init());
//   Get.put(ExpenseController());
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Expense Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }


import 'package:expense_manager_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controlers/expense_controller.dart';
import 'controlers/expense_controller.dart';
import 'models/expense.dart';
import 'services/user_preferences.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox('user_preferences');
  Get.put(UserPreferences().init());
  Get.put(ExpenseController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}



