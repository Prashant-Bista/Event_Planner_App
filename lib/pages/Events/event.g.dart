// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 4;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      eventBudget: fields[0] as Budget,
      eventExpenses: (fields[1] as List).cast<Expenses>(),
      eventGuests: (fields[3] as List).cast<Guests>(),
      eventTasks: (fields[2] as List).cast<Tasks>(),
      eventName: fields[5] as String,
      eventDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.eventBudget)
      ..writeByte(1)
      ..write(obj.eventExpenses)
      ..writeByte(2)
      ..write(obj.eventTasks)
      ..writeByte(3)
      ..write(obj.eventGuests)
      ..writeByte(5)
      ..write(obj.eventName)
      ..writeByte(6)
      ..write(obj.eventDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
