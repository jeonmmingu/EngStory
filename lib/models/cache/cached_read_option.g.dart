// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_read_option.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedReadOptionAdapter extends TypeAdapter<CachedReadOption> {
  @override
  final int typeId = 5;

  @override
  CachedReadOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedReadOption(
      speechSpeed: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CachedReadOption obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.speechSpeed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedReadOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
