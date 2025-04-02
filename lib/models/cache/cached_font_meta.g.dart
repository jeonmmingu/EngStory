// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_font_meta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedFontMetaAdapter extends TypeAdapter<CachedFontMeta> {
  @override
  final int typeId = 4;

  @override
  CachedFontMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedFontMeta(
      fontFamily: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CachedFontMeta obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.fontFamily);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedFontMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
