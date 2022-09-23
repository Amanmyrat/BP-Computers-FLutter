import 'dart:convert';
import 'dart:core';
import 'package:hive/hive.dart';
part 'computer.g.dart';

List<Computer> computerModelFromJson(String str) =>
    List<Computer>.from(json.decode(str).map((x) => Computer.fromJson(x)));

String computerModelToJson(List<Computer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId:0)
class Computer {
  @HiveField(0)
  final String office;
  @HiveField(1)
  final String uuid;
  @HiveField(2)
  final String deviceName;
  @HiveField(3)
  final String deviceType;
  @HiveField(4)
  final String responsible;
  @HiveField(5)
  final String job;
  @HiveField(6)
  final String manager;
  @HiveField(7)
  final String phone;
  @HiveField(8)
  final String privatePhone;
  @HiveField(9)
  final String room;
  @HiveField(10)
  final String domainName;
  @HiveField(11)
  final String ipAddress;
  @HiveField(12)
  final String macAddress;
  @HiveField(13)
  final String operatingSystem;
  @HiveField(14)
  final String cpu;
  @HiveField(15)
  final String drive;
  @HiveField(16)
  final String ram;
  @HiveField(17)
  final String network;
  @HiveField(18)
  final String internet;

  Computer({required this.office, required this.uuid, required this.deviceName, required this.deviceType, required this.responsible, required this.job, required this.manager, required this.phone, required this.privatePhone, required this.room, required this.domainName, required this.ipAddress, required this.macAddress, required this.operatingSystem, required this.cpu, required this.drive, required this.ram, required this.network, required this.internet});

  factory Computer.fromJson(Map<String, dynamic> json) => Computer(
      office : json ['district'],
      uuid : json ['uuid'],
      deviceName : json ['device_name'],
      deviceType : json ['device_type'],
      responsible : json ['responsible'],
      job : json ['job'],
      manager : json ['department_manager'],
      phone : json ['phone'],
      privatePhone : json ['private_phone'],
      room : json ['room'],
      domainName : json ['domain_name'],
      ipAddress : json ['ip_address'],
      macAddress : json ['mac_address'],
      operatingSystem : json ['operating_system'],
      cpu : json ['cpu'],
      drive : json ['drive'],
      ram : json ['ram'],
      network : json ['network'],
      internet : json ['internet'],
  );

  Map<String, dynamic> toJson() => {
    "office" :office,
    "uuid" : uuid,
    "deviceName" : deviceName,
    "deviceType" : deviceType,
    "responsible" : responsible,
    "job" : job,
    "manager" : manager,
    "phone" :phone,
    "privatePhone" : privatePhone,
    "room" : room,
    "domainName" : domainName,
    "ipAddress" : ipAddress,
    "macAddress" : macAddress,
    "operatingSystem" : operatingSystem,
    "cpu" : cpu,
    "drive" : drive,
    "ram" : ram,
    "network" : network,
    "internet" : internet,
  };

}
