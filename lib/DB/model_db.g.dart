// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsDBAdapter extends TypeAdapter<SongsDB> {
  @override
  final int typeId = 1;

  @override
  SongsDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsDB(
      name: fields[0] as String,
      songid: (fields[1] as List).cast<int>(),
      count: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SongsDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.songid)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
