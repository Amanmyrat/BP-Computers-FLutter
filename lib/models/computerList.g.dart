// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'computerList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComputerListAdapter extends TypeAdapter<ComputerList> {
  @override
  final int typeId = 1;

  @override
  ComputerList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComputerList(
      name: fields[0] as String,
      computerList: (fields[1] as List).cast<Computer>(),
    );
  }

  @override
  void write(BinaryWriter writer, ComputerList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.computerList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComputerListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
