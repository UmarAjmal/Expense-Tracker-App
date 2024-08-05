

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controlers/amount_controller.dart';
import '../models/amount.dart';

class EditAmountScreen extends StatelessWidget {
  final Amount amount;

  EditAmountScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    final AmountController amountController = Get.find();
    final TextEditingController amountInputController = TextEditingController(text: amount.amount.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF5004F),
        title: Text('Edit Amount'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _confirmDelete(context, amountController);
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
              controller: amountInputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Edit Amount',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double newAmount = double.parse(amountInputController.text);
                amountController.updateAmount(amount.key, newAmount); // Assume Amount has a `key` property
                Get.back();
              },
              child: Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, AmountController amountController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Amount'),
          content: Text('Are you sure you want to delete this amount?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                amountController.deleteAmount(amount.key); // Assume Amount has a `key` property
                Get.back(); // Close the dialog
                Get.back(); // Close the EditAmountScreen
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

