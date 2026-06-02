// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_zekr_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomZekrModelAdapter extends TypeAdapter<CustomZekrModel> {
  @override
  final int typeId = 100;

  @override
  CustomZekrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomZekrModel(
      text: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomZekrModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomZekrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
