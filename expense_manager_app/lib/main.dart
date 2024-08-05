

import 'package:expense_manager_app/Amount/models/amount.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Amount/controlers/amount_controller.dart';
import 'Amount/views/add_amount_screen.dart';
import 'Expense/controlers/expense_controller.dart';
import 'Expense/models/expense.dart';
import 'Expense/views/add_expense_screen.dart';
import 'Expense/views/edit_expense_screen.dart';
import 'Reports/repot_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/settings_screen.dart';
import 'Screens/splash_screen.dart';
import 'services/user_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Hive.init('path_to_hive_box');
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(AmountAdapter());
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox('user_preferences');
  await Hive.openBox('amounts');
  Get.put(await UserPreferences().init());
  Get.put(ExpenseController());
  Get.put(AmountController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      initialRoute: HomeScreen.routeName,
      // getPages: [
      //   GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
      //   GetPage(name: ReportsScreen.routeName, page: () => ReportsScreen()),
      //   GetPage(name: AddAmountScreen.routeName, page: () => AddAmountScreen()),
      //   GetPage(name: AddExpenseScreen.routeName, page: () => AddExpenseScreen()),
      //   // GetPage(name: EditExpenseScreen.routeName, page: () => EditExpenseScreen()),
      //   GetPage(name: SettingsScreen.routeName, page: () => SettingsScreen()),
      // ],
    );
  }
}


