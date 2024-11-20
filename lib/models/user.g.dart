// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class userAdapter extends TypeAdapter<user> {
  @override
  final int typeId = 0;

  @override
  user read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return user(
      username: fields[1] as String,
      password: fields[2] as String,
      like: (fields[3] as List).cast<String>(),
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, user obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.like);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is userAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
