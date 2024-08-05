

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import '../Amount/controlers/amount_controller.dart';
import '../Amount/views/add_amount_screen.dart';
import '../Expense/controlers/expense_controller.dart';
import '../Expense/views/add_expense_screen.dart';
import '../Expense/views/edit_expense_screen.dart';
import '../Reports/repot_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static var routeName;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ExpenseController expenseController = Get.find();
  final AmountController amountController = Get.find();
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomeScreen(), // Home Screen Widget
      ReportsScreen(), // Reports Screen Widget
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildHomeScreen() {
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
            colors: [Color(0xff842be1), Color(0xff1c0a36)],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Obx(() {
              return FadeTransition(
                opacity: _opacityAnimation,
                child: Card(
                  color: Color(0xffF9E400),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PieChart(
                      animationDuration: Duration(seconds: 3),
                      legendOptions: LegendOptions(
                        legendPosition: LegendPosition.left,
                      ),
                      chartRadius: 100,
                      dataMap: {
                        "Remaining": amountController.remainingAmount.value,
                        "Spent": amountController.totalExpenses.value,
                      },
                      colorList: [Color(0xffFFAF00), Color(0xffF5004F)],
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartType: ChartType.ring,
                    ),
                  ),
                ),
              );
            }),
            Obx(() {
              return FadeTransition(
                opacity: _opacityAnimation,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color(0xffF9E400),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // edgeInsets: EdgeInsets.all(8),
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Amount: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          '${amountController.totalAddedAmount.value.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Card(
              color: Color(0xffF9E400),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            AddAmountScreen()); // Navigate to AddAmountScreen
                      },
                      child: Text('Add Amount',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF5004F),
                      ),
                    ),
                  ),
                  SizedBox(width: 60),
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(AddExpenseScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF5004F),
                      ),
                      child: Text('Add Expense',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return FadeTransition(
                  opacity: _opacityAnimation,
                  child: ListView.builder(
                    itemCount: expenseController.expenses.length,
                    itemBuilder: (context, index) {
                      var expense = expenseController.expenses[index];
                      return Card(
                        color: Color(0xffF9E400),
                        child: ListTile(
                          title: Text(expense.category),
                          subtitle: Text(
                              '${expense.date.toLocal()} - ${expense.note}'),
                          trailing: Text('${expense.amount}'),
                          onTap: () {
                            Get.to(EditExpenseScreen(expense: expense));
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffF5004F),
        elevation: BorderSide.strokeAlignOutside,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
