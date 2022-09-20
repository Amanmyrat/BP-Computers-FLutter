// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'computer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComputerAdapter extends TypeAdapter<Computer> {
  @override
  final int typeId = 0;

  @override
  Computer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Computer(
      office: fields[0] as String,
      uuid: fields[1] as String,
      deviceName: fields[2] as String,
      deviceType: fields[3] as String,
      responsible: fields[4] as String,
      job: fields[5] as String,
      manager: fields[6] as String,
      phone: fields[7] as String,
      privatePhone: fields[8] as String,
      room: fields[9] as String,
      domainName: fields[10] as String,
      ipAddress: fields[11] as String,
      macAddress: fields[12] as String,
      operatingSystem: fields[13] as String,
      cpu: fields[14] as String,
      drive: fields[15] as String,
      ram: fields[16] as String,
      network: fields[17] as String,
      internet: fields[18] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Computer obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.office)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.deviceName)
      ..writeByte(3)
      ..write(obj.deviceType)
      ..writeByte(4)
      ..write(obj.responsible)
      ..writeByte(5)
      ..write(obj.job)
      ..writeByte(6)
      ..write(obj.manager)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.privatePhone)
      ..writeByte(9)
      ..write(obj.room)
      ..writeByte(10)
      ..write(obj.domainName)
      ..writeByte(11)
      ..write(obj.ipAddress)
      ..writeByte(12)
      ..write(obj.macAddress)
      ..writeByte(13)
      ..write(obj.operatingSystem)
      ..writeByte(14)
      ..write(obj.cpu)
      ..writeByte(15)
      ..write(obj.drive)
      ..writeByte(16)
      ..write(obj.ram)
      ..writeByte(17)
      ..write(obj.network)
      ..writeByte(18)
      ..write(obj.internet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComputerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
