// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import '../models/expense.dart';
//
// class ExpenseController extends GetxController {
//   var expenses = <Expense>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchExpenses();
//   }
//
//   void fetchExpenses() {
//     var expenseBox = Hive.box<Expense>('expenses');
//     expenses.assignAll(expenseBox.values.toList());
//   }
//
//   void addExpense(Expense expense) {
//     var expenseBox = Hive.box<Expense>('expenses');
//     expenseBox.add(expense);
//     fetchExpenses();
//   }
// }
//
//
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import '../models/expense.dart';
//
// class ExpenseController extends GetxController {
//   var expenses = <Expense>[].obs;
//   var salary = 0.0.obs;
//   var remainingBalance = 0.0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchExpenses();
//     loadSalary();
//   }
//
//   void fetchExpenses() {
//     var expenseBox = Hive.box<Expense>('expenses');
//     expenses.assignAll(expenseBox.values.toList());
//     updateRemainingBalance();
//   }
//
//   void addExpense(Expense expense) {
//     var expenseBox = Hive.box<Expense>('expenses');
//     expenseBox.add(expense);
//     fetchExpenses();
//   }
//
//   void loadSalary() {
//     var prefs = Hive.box('user_preferences');
//     salary.value = prefs.get('salary', defaultValue: 0.0);
//     updateRemainingBalance();
//   }
//
//   void setSalary(double value) {
//     var prefs = Hive.box('user_preferences');
//     prefs.put('salary', value);
//     salary.value = value;
//     updateRemainingBalance();
//   }
//
//   void updateRemainingBalance() {
//     double totalExpenses = expenses.fold(0.0, (sum, item) => sum + item.amount);
//     remainingBalance.value = salary.value - totalExpenses;
//   }
// }
//
//




import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/expense.dart';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  var salary = 0.0.obs;
  var remainingBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSalary();
    loadExpenses();
  }

  void loadSalary() {
    var box = Hive.box('user_preferences');
    salary.value = box.get('salary', defaultValue: 0.0);
    calculateRemainingBalance();
  }

  void setSalary(double newSalary) {
    var box = Hive.box('settings');
    salary.value = newSalary;
    box.put('salary', newSalary);
    calculateRemainingBalance();
  }

  void loadExpenses() {
    var box = Hive.box<Expense>('expenses');
    expenses.value = box.values.toList();
    calculateRemainingBalance();
  }

  void addExpense(Expense expense) {
    var box = Hive.box<Expense>('expenses');
    box.add(expense);
    expenses.add(expense);
    calculateRemainingBalance();
  }

  void updateExpense(Expense oldExpense, String category, String note, double amount, DateTime date) {
    var box = Hive.box<Expense>('expenses');
    var index = expenses.indexOf(oldExpense);
    if (index != -1) {
      var updatedExpense = oldExpense.copyWith(category: category, note: note, amount: amount, date: date);
      box.putAt(index, updatedExpense);
      expenses[index] = updatedExpense;
      calculateRemainingBalance();
    }
  }

  void deleteExpense(Expense expense) {
    var box = Hive.box<Expense>('expenses');
    var index = expenses.indexOf(expense);
    if (index != -1) {
      box.deleteAt(index);
      expenses.removeAt(index);
      calculateRemainingBalance();
    }
  }

  void calculateRemainingBalance() {
    var totalSpent = expenses.fold(0.0, (sum, item) => sum + item.amount);
    remainingBalance.value = salary.value - totalSpent;
  }
}
