// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_story_script.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedStoryScriptAdapter extends TypeAdapter<CachedStoryScript> {
  @override
  final int typeId = 1;

  @override
  CachedStoryScript read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedStoryScript(
      id: fields[0] as String,
      storyId: fields[1] as String,
      index: fields[2] as int,
      role: fields[3] as String,
      textEn: fields[4] as String,
      textKo: fields[5] as String,
      updatedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedStoryScript obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storyId)
      ..writeByte(2)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.textEn)
      ..writeByte(5)
      ..write(obj.textKo)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedStoryScriptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
