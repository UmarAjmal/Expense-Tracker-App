
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../controlers/amount_controller.dart';
import 'edit_amount_screen.dart';

class AddAmountScreen extends StatefulWidget {
  static var routeName;

  @override
  _AddAmountScreenState createState() => _AddAmountScreenState();
}

class _AddAmountScreenState extends State<AddAmountScreen> {
  final AmountController amountController = Get.find();
  final TextEditingController amountInputController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF5004F),
        title: Text('Add Amount'),
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
                labelText: 'Enter Amount',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.black,
                        hintColor: Colors.black,
                        colorScheme: const ColorScheme.light(primary: Colors.black),
                        buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary,
                        ),
                        dialogBackgroundColor: Colors.amber,
                        textTheme: const TextTheme(
                          headlineMedium: TextStyle(color: Colors.black),
                          titleMedium: TextStyle(color: Colors.black),
                          bodyMedium: TextStyle(color: Colors.black),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              child: Text("Select Date"),
            ),
            SizedBox(height: 10),
            Text("Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double amount = double.parse(amountInputController.text);
                amountController.addAmount(amount, selectedDate);
                Get.back();
              },
              child: Text('Save Amount',style : TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff000000),
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: amountController.amounts.length,
                  itemBuilder: (context, index) {
                    // Get the Amount object by its key
                    var key = amountController.amounts.keys.toList()[index];
                    var amount = amountController.amounts[key];

                    return Card(
                      color: Color(0xffF9E400),
                      child: ListTile(
                        title: Text('Amount: \$${amount?.amount.toStringAsFixed(2)}'),
                        subtitle: Text('${amount?.date.toLocal()}'),
                        onTap: () {
                          // Navigate to EditAmountScreen with the selected Amount
                          Get.to(() => EditAmountScreen(amount: amount!));
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
