import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controlers/expense_controller.dart';
import '../models/expense.dart';

class EditExpenseScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.find();
  final Expense expense;

  static var routeName;

  EditExpenseScreen({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryController = TextEditingController(text: expense.category);
    final TextEditingController noteController = TextEditingController(text: expense.note);
    final TextEditingController amountController = TextEditingController(text: expense.amount.toString());
    DateTime selectedDate = expense.date;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
        backgroundColor: const Color(0xffF5004F),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteExpense(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Note'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate) {
                  selectedDate = picked;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff010101),
              ),
              child: Text('Select Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveExpense(context, categoryController.text, noteController.text, double.parse(amountController.text), selectedDate);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff010101),
              ),
              child: const Text('Save',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  void _saveExpense(BuildContext context, String category, String note, double amount, DateTime date) {
    expenseController.updateExpense(expense , category , note, amount, date);
    Get.back();
  }

  void _deleteExpense(BuildContext context) {
    expenseController.deleteExpense(expense);
    Get.back();
  }
}
