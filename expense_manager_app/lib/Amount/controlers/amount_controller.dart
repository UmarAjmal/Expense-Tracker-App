

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../Expense/controlers/expense_controller.dart';
import '../models/amount.dart';
// import '../Expense/controlers/expense_controller.dart'; // Import ExpenseController if needed

class AmountController extends GetxController {
  late Box _amountBox; // Declare the box as late
  var amounts = <int, Amount>{}.obs;
  var remainingAmount = 0.0.obs;
  var totalAddedAmount = 0.0.obs;
  var totalExpenses = 0.0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeBox(); // Ensure the box is initialized before any other operations
    await _loadAmounts(); // Load amounts after the box is initialized
  }

  Future<void> _initializeBox() async {
    if (!Hive.isBoxOpen('amounts')) {
      _amountBox = await Hive.openBox<Amount>('amounts');
    } else {
      _amountBox = Hive.box('amounts');
    }
  }

  Future<void> _loadAmounts() async {
    try {
      amounts.value = Map.fromIterables(
        _amountBox.keys.cast<int>(),
        _amountBox.values.cast<Amount>(),
      );
      calculateBalances(); // Recalculate balances after loading
    } catch (e) {
      print("Error loading amounts: $e");
    }
  }

  Future<void> addAmount(double amount, DateTime date) async {
    try {
      var newAmount = Amount(date: date, amount: amount);
      var key = _amountBox.length;
      await _amountBox.put(key, newAmount);
      amounts[key] = newAmount; // Update the reactive map
      calculateBalances(); // Recalculate balances after adding
    } catch (e) {
      print("Error adding amount: $e");
    }
  }

  Future<void> updateAmount(int key, double newAmount) async {
    try {
      var oldAmount = _amountBox.get(key);
      if (oldAmount != null) {
        var updatedAmount = Amount(date: oldAmount.date, amount: newAmount);
        await _amountBox.put(key, updatedAmount);
        amounts[key] = updatedAmount; // Update the reactive map
        calculateBalances(); // Recalculate balances after updating
      } else {
        print("Amount with key $key not found for update.");
      }
    } catch (e) {
      print("Error updating amount: $e");
    }
  }

  Future<void> deleteAmount(int key) async {
    try {
      if (_amountBox.containsKey(key)) {
        await _amountBox.delete(key);
        amounts.remove(key); // Update the reactive map
        calculateBalances(); // Recalculate balances after deleting
      } else {
        print("Amount with key $key not found for deletion.");
      }
    } catch (e) {
      print("Error deleting amount: $e");
    }
  }

  void calculateBalances() {
    final expenseController = Get.find<ExpenseController>();

    totalAddedAmount.value = amounts.values.fold(
      0.0,
          (sum, amount) => sum + amount.amount,
    );

    totalExpenses.value = expenseController.expenses.fold(
      0.0,
          (sum, expense) => sum + expense.amount,
    );

    remainingAmount.value = totalAddedAmount.value - totalExpenses.value;
  }
}
