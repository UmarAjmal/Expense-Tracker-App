// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:expense_manager_app/_app/controlers/expense_controller.dart';
// import '../controlers/expense_controller.dart';
// import 'add_expense_screen.dart';
// import 'settings_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   final ExpenseController expenseController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense Tracker'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               Get.to(SettingsScreen());
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue, Colors.green],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Obx(() {
//           return ListView.builder(
//             itemCount: expenseController.expenses.length,
//             itemBuilder: (context, index) {
//               var expense = expenseController.expenses[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(expense.category),
//                   subtitle: Text('${expense.date.toLocal()} - ${expense.note}'),
//                   trailing: Text('\$${expense.amount}'),
//                 ),
//               );
//             },
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(AddExpenseScreen());
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pie_chart/pie_chart.dart'; // Updated import
// import '../controlers/expense_controller.dart';
// import 'add_expense_screen.dart';
// import 'settings_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   final ExpenseController expenseController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(0xffF5004F),
//         title: Text('Expense Manager'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               Get.to(SettingsScreen());
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xff7C00FE),Color(0xff7C00FE)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             Obx(() {
//               return Card(
//                 // height: 200,
//                 // width: 400,
//
//                 color: Color(0xffF9E400),
//
//                 child: Padding(
//
//
//                   padding: const EdgeInsets.all(8.0),
//                   child: PieChart(
//                     dataMap: {
//                       "Remaining": expenseController.remainingBalance.value,
//                       "Spent": expenseController.salary.value - expenseController.remainingBalance.value,
//                     },
//                     colorList: [Color(0xffFFAF00), Color(0xffF5004F)],
//                     chartValuesOptions: ChartValuesOptions(
//                       showChartValuesInPercentage: true,
//                     ),
//                     chartType: ChartType.ring,
//                   ),
//                 ),
//               );
//             }),
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     final TextEditingController salaryController = TextEditingController();
//                     return AlertDialog(
//                       title: Text('Set Monthly Salary'),
//                       content: Container(width: MediaQuery.of(context).size.width*0.10,
//                         child: TextField(
//                           controller: salaryController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(labelText: 'Enter your monthly salary'),
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             double salary = double.parse(salaryController.text);
//                             expenseController.setSalary(salary);
//                             Get.back();
//                           },
//                           child: Text('Save'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text('Set Monthly Salary'),
//             ),
//             Expanded(
//               child: Obx(() {
//                 return ListView.builder(
//                   itemCount: expenseController.expenses.length,
//                   itemBuilder: (context, index) {
//                     var expense = expenseController.expenses[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(expense.category),
//                         subtitle: Text('${expense.date.toLocal()} - ${expense.note}'),
//                         trailing: Text('\$${expense.amount}'),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(AddExpenseScreen());
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pie_chart/pie_chart.dart'; // Updated import
// import 'package:intl/intl.dart';
// import '../controlers/expense_controller.dart';
// import 'add_expense_screen.dart';
// import 'settings_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   final ExpenseController expenseController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffF5004F),
//         title: Text('Expense Manager'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               Get.to(SettingsScreen());
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xff7C00FE),Color(0xff7C00FE)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             Obx(() {
//               return Card(
//                 color: Color(0xffF9E400),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: PieChart(
//                     dataMap: {
//                       "Remaining": expenseController.remainingBalance.value,
//                       "Spent": expenseController.salary.value - expenseController.remainingBalance.value,
//                     },
//                     colorList: [Color(0xffFFAF00), Color(0xffF5004F)],
//                     chartValuesOptions: ChartValuesOptions(
//                       showChartValuesInPercentage: true,
//                     ),
//                     chartType: ChartType.ring,
//                   ),
//                 ),
//               );
//             }),
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     final TextEditingController salaryController = TextEditingController();
//                     DateTime selectedDate = DateTime.now();
//
//                     return AlertDialog(
//                       backgroundColor: Color(0xffF9E400),
//                       title: Text('Set Monthly Salary'),
//                       content: Container(
//                         width: MediaQuery.of(context).size.width * 0.8, // Set the width here
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             TextField(
//                               controller: salaryController,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(labelText: 'Enter your monthly salary'),
//                             ),
//                             SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 final DateTime? picked = await showDatePicker(
//                                   context: context,
//                                   initialDate: selectedDate,
//                                   firstDate: DateTime(2000),
//                                   lastDate: DateTime(2101),
//                                     builder: (BuildContext context, Widget? child) {
//                                       return Theme(
//                                         data: ThemeData.light().copyWith(
//                                           primaryColor: Colors.black,
//                                           hintColor: Colors.black,
//                                           colorScheme: const ColorScheme.light(
//                                               primary: Colors.black),
//                                           buttonTheme: const ButtonThemeData(
//                                             textTheme: ButtonTextTheme.primary,
//                                           ),
//                                           dialogBackgroundColor: Colors.amber,
//                                           textTheme: const TextTheme(
//                                             headlineMedium: TextStyle(color: Colors.black),
//                                             titleMedium: TextStyle(color: Colors.black),
//                                             bodyMedium: TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         child: child!,
//                                       );
//                                     });
//                                 if (picked != null && picked != selectedDate) {
//                                   selectedDate = picked;
//                                 }
//
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color of the button
//                               ),
//                               child: Text("Select Date"),
//                             ),
//                             SizedBox(height: 10),
//                             Text("Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
//                           ],
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             double salary = double.parse(salaryController.text);
//                             expenseController.setSalary(salary);
//                             Get.back();
//                           },
//                           child: Text('Save'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text('Set Monthly Salary'),
//             ),
//             Expanded(
//               child: Obx(() {
//                 return ListView.builder(
//                   itemCount: expenseController.expenses.length,
//                   itemBuilder: (context, index) {
//                     var expense = expenseController.expenses[index];
//                     return Card(
//                       color:  Color(0xffF9E400),
//                       child: ListTile(
//                         title: Text(expense.category),
//                         subtitle: Text('${expense.date.toLocal()} - ${expense.note}'),
//                         trailing: Text('\$${expense.amount}'),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(AddExpenseScreen());
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart'; // Updated import
import 'package:intl/intl.dart';
import '../controlers/expense_controller.dart';
import 'add_expense_screen.dart';
import 'edit_expense_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF5004F),
        title: Text('Expense Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(SettingsScreen());
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff7C00FE), Color(0xff7C00FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Obx(() {
              return Card(
                color: Color(0xffF9E400),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(
                    dataMap: {
                      "Remaining": expenseController.remainingBalance.value,
                      "Spent": expenseController.salary.value - expenseController.remainingBalance.value,
                    },
                    colorList: [Color(0xffFFAF00), Color(0xffF5004F)],
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                    chartType: ChartType.ring,
                  ),
                ),
              );
            }),
            Card(
              // height: 70,
              // width: 2000,
              color: Color(0xffF9E400),
              // padding:EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final TextEditingController salaryController = TextEditingController();
                          DateTime selectedDate = DateTime.now();
                          return AlertDialog(
                            backgroundColor: Color(0xffF9E400),
                            title: Text('Add Salary', style: TextStyle(color: Colors.black),),
                            content: Container(
                              width: MediaQuery.of(context).size.width * 0.8, // Set the width here
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: salaryController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Enter your monthly salary'),
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
                                              colorScheme: const ColorScheme.light(
                                                  primary: Colors.black),
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
                                        selectedDate = picked;
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.black, // Text color of the button
                                    ),
                                    child: Text("Select Date"),
                                  ),
                                  SizedBox(height: 10),
                                  Text("Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  double salary = double.parse(salaryController.text);
                                  expenseController.setSalary(salary);
                                  Get.back();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Set Monthly Salary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF5004F), // Background color of the button
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(AddExpenseScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF5004F), // Background color of the button
                    ),
                    child: Text('Add Expense',style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: expenseController.expenses.length,
                  itemBuilder: (context, index) {
                    var expense = expenseController.expenses[index];
                    return Card(
                      color: Color(0xffF9E400),
                      child: ListTile(
                        title: Text(expense.category),
                        subtitle: Text('${expense.date.toLocal()} - ${expense.note}'),
                        trailing: Text('${expense.amount}'),
                        onTap: () {
                          Get.to(EditExpenseScreen(expense: expense));
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
