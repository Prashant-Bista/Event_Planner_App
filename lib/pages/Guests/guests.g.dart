// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guests.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GuestsAdapter extends TypeAdapter<Guests> {
  @override
  final int typeId = 1;

  @override
  Guests read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Guests(
      guestName: fields[0] as String,
      membersNo: fields[1] as int,
      invited: fields[2] as bool,
      contact: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Guests obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.guestName)
      ..writeByte(1)
      ..write(obj.membersNo)
      ..writeByte(2)
      ..write(obj.invited)
      ..writeByte(3)
      ..write(obj.contact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuestsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
