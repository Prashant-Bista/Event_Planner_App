// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 6;

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
      eventDate: fields[6] as DateTime?,
      eventVendors: (fields[4] as List).cast<Vendors>(),
      vendorsCount: fields[7] as int,
      guestsCount: fields[8] as int,
      eventSchedule: (fields[9] as List).cast<Schedule>(),
      eventVenue: fields[10] as Venue?,
      predictedBudget: fields[11] as double?,
      eventId: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.eventBudget)
      ..writeByte(1)
      ..write(obj.eventExpenses)
      ..writeByte(2)
      ..write(obj.eventTasks)
      ..writeByte(3)
      ..write(obj.eventGuests)
      ..writeByte(4)
      ..write(obj.eventVendors)
      ..writeByte(5)
      ..write(obj.eventName)
      ..writeByte(6)
      ..write(obj.eventDate)
      ..writeByte(7)
      ..write(obj.vendorsCount)
      ..writeByte(8)
      ..write(obj.guestsCount)
      ..writeByte(9)
      ..write(obj.eventSchedule)
      ..writeByte(10)
      ..write(obj.eventVenue)
      ..writeByte(11)
      ..write(obj.predictedBudget)
      ..writeByte(12)
      ..write(obj.eventId);
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
