import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class UserPreferences extends GetxService {
  SharedPreferences? prefs;

  Future<UserPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  String get defaultCurrency => prefs?.getString('defaultCurrency') ?? 'PKR';

  set defaultCurrency(String value) {
    prefs?.setString('defaultCurrency', value);
  }

  bool get notificationsEnabled => prefs?.getBool('notificationsEnabled') ?? true;

  set notificationsEnabled(bool value) {
    prefs?.setBool('notificationsEnabled', value);
  }
}


//
// import 'package:hive/hive.dart';
// import '../models/expense.dart';
// // import 'expense.dart'; // Import your Expense model
//
// class ExpenseService {
//   static final ExpenseService _instance = ExpenseService._internal();
//   factory ExpenseService() => _instance;
//   ExpenseService._internal();
//
//   late Box<Expense> _expenseBox;
//
//   Future<void> init() async {
//     Hive.init('path_to_hive_directory'); // Specify the path if not using default
//     Hive.registerAdapter(ExpenseAdapter()); // Register the adapter
//     _expenseBox = await Hive.openBox<Expense>('expenses');
//   }
//
//   Future<void> addExpense(Expense expense) async {
//     await _expenseBox.add(expense);
//   }
//
//   Future<void> updateExpense(int index, Expense updatedExpense) async {
//     await _expenseBox.putAt(index, updatedExpense);
//   }
//
//   Future<void> deleteExpense(int index) async {
//     await _expenseBox.deleteAt(index);
//   }
//
//   List<Expense> getExpenses() {
//     return _expenseBox.values.toList();
//   }
// }
