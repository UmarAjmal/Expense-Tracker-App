import 'package:hive/hive.dart';

part 'amount.g.dart';

@HiveType(typeId: 1)
class Amount extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double amount;

  Amount({
    required this.date,
    required this.amount,
  });

  Amount copyWith({
    DateTime? date,
    double? amount,
  }) {
    return Amount(
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }
}
