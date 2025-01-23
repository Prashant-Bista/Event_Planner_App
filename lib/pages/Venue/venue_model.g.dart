// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VenueAdapter extends TypeAdapter<Venue> {
  @override
  final int typeId = 8;

  @override
  Venue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Venue(
      venueCost: fields[1] as double,
      venueId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Venue obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.venueId)
      ..writeByte(1)
      ..write(obj.venueCost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VenueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
