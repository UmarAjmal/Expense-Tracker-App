
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../Expense/controlers/expense_controller.dart';
import '../Amount/controlers/amount_controller.dart';
import '../Screens/home_screen.dart';

class ReportsScreen extends StatelessWidget {
  static const routeName = '/reports';
  final ExpenseController expenseController = Get.find();
  final AmountController amountController = Get.find();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM yyyy').format(now);

    double totalAmount = amountController.amounts.values
        .fold(0.0, (sum, amount) => sum + amount.amount);
    double expenses = expenseController.expenses.value
        .where((expense) =>
    expense.date.month == now.month && expense.date.year == now.year)
        .fold(0.0, (sum, expense) => sum + expense.amount);

    double remainingBalance = totalAmount - expenses;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF5004F),
        title: Text('Monthly Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report for $currentMonth',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Text('Amount Added: \$${totalAmount.toStringAsFixed(2)}'),
            Text('Expenses: \$${expenses.toStringAsFixed(2)}'),
            Text('Remaining Balance: \$${remainingBalance.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _printReport(context, totalAmount, expenses, remainingBalance);
              },
              child: Text(
                'Print Report',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffF5004F),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reports',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Get.offAllNamed(HomeScreen.routeName);
          } else if (index == 1) {
            Get.offAllNamed(ReportsScreen.routeName);
          }
        },
      ),
    );
  }

  void _printReport(BuildContext context, double totalAmount, double expenses,
      double remainingBalance) async {
    try {
      final pdf = pw.Document();
      final headerStyle =
      pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold);
      final subHeaderStyle =
      pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);
      final bodyStyle = pw.TextStyle(fontSize: 16);
      final tableHeaderStyle = pw.TextStyle(
          fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.orange);
      final tableBodyStyle = pw.TextStyle(fontSize: 14);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Expense Manager', style: headerStyle),
              pw.SizedBox(height: 20),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Container(
                      color: PdfColors.orange,
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('0001',
                          style: pw.TextStyle(color: PdfColors.white)),
                    ),
                    pw.Text('RP0112', style: subHeaderStyle),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('MONTHLY REPORT',
                  style: subHeaderStyle.copyWith(color: PdfColors.orange)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: [
                  'Expense Description',
                  'Date',
                  'Category',
                  'Amount(USD)',
                ],
                data: expenseController.expenses.value
                    .where((expense) =>
                expense.date.month == DateTime.now().month &&
                    expense.date.year == DateTime.now().year)
                    .map((expense) => [
                  expense.note, // Description
                  DateFormat('yyyy-MM-dd').format(expense.date), // Date
                  expense.category, // Category
                  '\$${expense.amount.toStringAsFixed(2)}', // Amount
                ])
                    .toList(),
                headerStyle: tableHeaderStyle,
                cellStyle: tableBodyStyle,
                headerDecoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                  color: PdfColors.orange,
                ),
                cellAlignment: pw.Alignment.centerLeft,
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Total Expense Amount', style: tableBodyStyle),
                        pw.Text('Non reimbursable amount',
                            style: tableBodyStyle),
                        pw.Text('Advance amount received',
                            style: tableBodyStyle),
                      ],
                    ),
                  ),
                  pw.Container(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('${expenses.toStringAsFixed(2)}',
                            style: tableBodyStyle),
                        pw.Text('0.00', style: tableBodyStyle),
                        pw.Text('0.00', style: tableBodyStyle),
                        pw.Container(
                          color: PdfColors.orange,
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text('Total ${expenses.toStringAsFixed(2)}',
                              style: pw.TextStyle(color: PdfColors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text('Summary:', style: subHeaderStyle),
              pw.Text('Total Amount Added: ${totalAmount.toStringAsFixed(2)}',
                  style: bodyStyle),
              pw.Text('Total Expenses: ${expenses.toStringAsFixed(2)}',
                  style: bodyStyle),
              pw.Text(
                  'Remaining Balance: ${remainingBalance.toStringAsFixed(2)}',
                  style: bodyStyle),
              pw.SizedBox(height: 20),
            ],
          ),
        ),
      );

      final pdfData = await pdf.save();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfData,
      );
    } catch (e) {
      print("Error printing report: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to print report: $e"),
        ),
      );
    }
  }
}
