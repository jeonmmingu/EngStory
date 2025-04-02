// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_ui_meta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedUIMetaAdapter extends TypeAdapter<CachedUIMeta> {
  @override
  final int typeId = 3;

  @override
  CachedUIMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedUIMeta(
      themeColor: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CachedUIMeta obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.themeColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedUIMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
