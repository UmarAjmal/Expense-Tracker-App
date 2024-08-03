// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'expense.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class ExpenseAdapter extends TypeAdapter<Expense> {
//   @override
//   final int typeId = 0;
//
//   @override
//   Expense read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Expense(
//       date: fields[0] as DateTime,
//       amount: fields[1] as double,
//       note: fields[2] as String, ,
//        amount: fields[3] as String,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, Expense obj) {
//     writer
//       ..writeByte(4)
//       ..writeByte(0)
//       ..write(obj.date)
//       ..writeByte(1)
//       ..write(obj.amount)
//       ..writeByte(2)
//       ..write(obj.category)
//       ..writeByte(3)
//       ..write(obj.note);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is ExpenseAdapter &&
//               runtimeType == other.runtimeType &&
//               typeId == other.typeId;
// }
//
//


// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 0;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      date: fields[0] as DateTime,
      amount: fields[1] as double,
      category: fields[2] as String,
      note: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ExpenseAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
