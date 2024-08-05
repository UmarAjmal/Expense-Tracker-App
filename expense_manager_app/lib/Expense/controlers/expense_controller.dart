

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
    loadExpenses();
    // Uncomment the following line if salary loading is required
    // loadSalary();
  }

  // void loadSalary() {
  //   try {
  //     var box = Hive.box('user_preferences');
  //     salary.value = box.get('salary', defaultValue: 0.0);
  //     calculateRemainingBalance();
  //   } catch (e) {
  //     print("Error loading salary: $e");
  //   }
  // }

  // void setSalary(double newSalary) {
  //   try {
  //     var box = Hive.box('user_preferences');
  //     salary.value = newSalary;
  //     box.put('salary', newSalary);
  //     calculateRemainingBalance();
  //   } catch (e) {
  //     print("Error setting salary: $e");
  //   }
  // }

  void loadExpenses() {
    try {
      var box = Hive.box<Expense>('expenses');
      expenses.value = box.values.toList();
      calculateRemainingBalance();
    } catch (e) {
      print("Error loading expenses: $e");
    }
  }

  void addExpense(Expense expense) {
    try {
      var box = Hive.box<Expense>('expenses');
      box.add(expense);
      expenses.add(expense);
      calculateRemainingBalance();
    } catch (e) {
      print("Error adding expense: $e");
    }
  }

  void updateExpense(Expense oldExpense, String category, String note, double amount, DateTime date) {
    try {
      var box = Hive.box<Expense>('expenses');
      var index = expenses.indexOf(oldExpense);
      if (index != -1) {
        var updatedExpense = oldExpense.copyWith(category: category, note: note, amount: amount, date: date);
        box.putAt(index, updatedExpense);
        expenses[index] = updatedExpense;
        calculateRemainingBalance();
      } else {
        print("Expense not found for update.");
      }
    } catch (e) {
      print("Error updating expense: $e");
    }
  }

  void deleteExpense(Expense expense) {
    try {
      var box = Hive.box<Expense>('expenses');
      var index = expenses.indexOf(expense);
      if (index != -1) {
        box.deleteAt(index);
        expenses.removeAt(index);
        calculateRemainingBalance();
      } else {
        print("Expense not found for deletion.");
      }
    } catch (e) {
      print("Error deleting expense: $e");
    }
  }

  void calculateRemainingBalance() {
    try {
      var totalSpent = expenses.fold(0.0, (sum, item) => sum + item.amount);
      remainingBalance.value = salary.value - totalSpent;
    } catch (e) {
      print("Error calculating remaining balance: $e");
    }
  }
}
