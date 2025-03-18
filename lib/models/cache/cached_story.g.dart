// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedStoryAdapter extends TypeAdapter<CachedStory> {
  @override
  final int typeId = 0;

  @override
  CachedStory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedStory(
      id: fields[0] as String,
      title: fields[1] as String,
      source: fields[2] as String,
      category: fields[3] as String,
      readTime: fields[4] as String,
      updatedAt: fields[5] as DateTime,
      lastReadScriptIndex: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CachedStory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.source)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.readTime)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.lastReadScriptIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedStoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
