// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VendorsAdapter extends TypeAdapter<Vendors> {
  @override
  final int typeId = 4;

  @override
  Vendors read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vendors(
      name: fields[0] as String?,
      contact: fields[1] as String?,
      isBooked: fields[2] as bool?,
      price: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Vendors obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.contact)
      ..writeByte(2)
      ..write(obj.isBooked)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
