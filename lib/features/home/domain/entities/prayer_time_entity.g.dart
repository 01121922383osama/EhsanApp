// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_time_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerTimeEntityAdapter extends TypeAdapter<PrayerTimeEntity> {
  @override
  final int typeId = 0;

  @override
  PrayerTimeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerTimeEntity(
      fajr: fields[0] as DateTime,
      sunrise: fields[1] as DateTime,
      dhuhr: fields[2] as DateTime,
      asr: fields[3] as DateTime,
      maghrib: fields[4] as DateTime,
      isha: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PrayerTimeEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fajr)
      ..writeByte(1)
      ..write(obj.sunrise)
      ..writeByte(2)
      ..write(obj.dhuhr)
      ..writeByte(3)
      ..write(obj.asr)
      ..writeByte(4)
      ..write(obj.maghrib)
      ..writeByte(5)
      ..write(obj.isha);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerTimeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
