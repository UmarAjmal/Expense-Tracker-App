// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/expense.dart';
// import 'package:expense_manager_app/controlers/expense_controller.dart';
//
// class AddExpenseScreen extends StatelessWidget {
//   final ExpenseController expenseController = Get.find();
//
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController noteController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(0xffF5004F),
//         title: Text('Add Expense'),
//       ),
//       backgroundColor: Color(0xff9f5de8),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: dateController,
//               decoration: InputDecoration(labelText: 'Date'),style: TextStyle(color: Colors.black),
//               onTap: () async {
//                 DateTime? date = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                 );
//                 if (date != null) {
//                   dateController.text = date.toIso8601String();
//                 }
//               },
//             ),
//             TextField(
//               controller: amountController,
//               decoration: InputDecoration(labelText: 'Amount'),style: TextStyle(color: Colors.black),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: categoryController,
//               decoration: InputDecoration(labelText: 'Category'),style: TextStyle(color: Colors.black),
//             ),
//             TextField(
//               controller: noteController,
//               decoration: InputDecoration(labelText: 'Note'),style: TextStyle(color: Colors.black),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color of the button
//               ),
//               onPressed: () {
//                 var expense = Expense(
//                   DateTime.parse(dateController.text),
//                   double.parse(amountController.text),
//                   categoryController.text,
//                   noteController.text,
//                 );
//                 expenseController.addExpense(expense );
//                 Get.back();
//               },
//               child: Text('Add Expense'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//




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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffF5004F),
        title: const Text('Add Expense'),
      ),
      backgroundColor: const Color(0xff9f5de8),
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
