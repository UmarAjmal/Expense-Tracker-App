// import 'package:hive/hive.dart';
//
// part 'expense.g.dart';
//
// @HiveType(typeId: 0)
// class Expense extends HiveObject {
//   @HiveField(0)
//   final DateTime date;
//
//   @HiveField(1)
//   final double amount;
//
//   @HiveField(2)
//   final String category;
//
//   @HiveField(3)
//   final String note;
//
//   Expense(
//       this.date,  this.amount,  this.category,  this.note);
// }


import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String note;

  Expense({
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
  });
  Expense copyWith({
    String? category,
    DateTime? date,
    String? note,
    double? amount,
  }) {
    return Expense(
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
      amount: amount ?? this.amount,
    );
  }
}
