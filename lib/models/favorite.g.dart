// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class favoriteAdapter extends TypeAdapter<favorite> {
  @override
  final int typeId = 0;

  @override
  favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return favorite(
      like: fields[1] as String,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, favorite obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.like);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is favoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
