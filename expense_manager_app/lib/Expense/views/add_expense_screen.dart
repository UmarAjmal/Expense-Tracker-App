
import 'package:expense_manager_app/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/expense.dart';
import '../controlers/expense_controller.dart'; // Adjusted path to the correct controller location

class AddExpenseScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.find();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  static var routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffF5004F),
        title: const Text('Add Expense'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(SettingsScreen());
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
                labelStyle: TextStyle(color: Colors.black),
              ),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  dateController.text = date.toIso8601String();
                }
              },
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.black),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Note',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Text color of the button
              ),
              onPressed: () {
                // Validate inputs before adding expense
                if (dateController.text.isEmpty ||
                    amountController.text.isEmpty ||
                    categoryController.text.isEmpty ||
                    noteController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please fill in all fields',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                try {
                  var expense = Expense(
                    category: categoryController.text,
                    date: DateTime.parse(dateController.text),
                    note: noteController.text,
                    amount: double.parse(amountController.text),
                  );
                  expenseController.addExpense(expense);
                  Get.back();
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'Invalid input: ${e.toString()}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
