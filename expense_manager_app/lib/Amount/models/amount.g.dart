// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amount.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmountAdapter extends TypeAdapter<Amount> {
  @override
  final int typeId = 1;

  @override
  Amount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Amount(
      date: fields[0] as DateTime,
      amount: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Amount obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AmountAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
