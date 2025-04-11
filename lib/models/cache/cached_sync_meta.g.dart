// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_sync_meta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedSyncMetaAdapter extends TypeAdapter<CachedSyncMeta> {
  @override
  final int typeId = 2;

  @override
  CachedSyncMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedSyncMeta(
      lastSyncedAt: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedSyncMeta obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lastSyncedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedSyncMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
