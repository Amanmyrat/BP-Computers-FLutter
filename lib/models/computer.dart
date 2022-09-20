import 'dart:core';
import 'package:hive/hive.dart';

 part 'computer.g.dart';

 @HiveType(typeId:0)
class Computer {
  @HiveField(0)
  late String office;
  @HiveField(1)
  late String uuid;
  @HiveField(2)
  late String deviceName;
  @HiveField(3)
  late String deviceType;
  @HiveField(4)
  late String responsible;
  @HiveField(5)
  late String job;
  @HiveField(6)
  late String manager;
  @HiveField(7)
  late String phone;
  @HiveField(8)
  late String privatePhone;
  @HiveField(9)
  late String room;
  @HiveField(10)
  late String domainName;
  @HiveField(11)
  late String ipAddress;
  @HiveField(12)
  late String macAddress;
  @HiveField(13)
  late String operatingSystem;
  @HiveField(14)
  late String cpu;
  @HiveField(15)
  late String drive;
  @HiveField(16)
  late String ram;
  @HiveField(17)
  late String network;
  @HiveField(18)
  late String internet;

  Computer({required this.office, required this.uuid, required this.deviceName, required this.deviceType, required this.responsible, required this.job, required this.manager, required this.phone, required this.privatePhone, required this.room, required this.domainName, required this.ipAddress, required this.macAddress, required this.operatingSystem, required this.cpu, required this.drive, required this.ram, required this.network, required this.internet});

  static Computer fromJson(Map<String, dynamic> json) => Computer(
    office : json ['Prokuratura'],
    uuid : json ['Uuid'],
    deviceName : json ['Device Name'],
    deviceType : json ['Device Type'],
    responsible : json ['Responsible Person'],
    job : json ['Job Title'],
    manager : json ['Department Manager'],
    phone : "+993 ${json ['Phone Prefix']} ${json ['Phone']}",
    privatePhone : "+993 ${json ['Private Phone']}",
    room : json ['Room'],
    domainName : json ['Domain Name'],
    ipAddress : json ['Ip Prefix'] + "." + json ['Ip Suffix'],
    macAddress : json ['Mac Prefix'] + ":" + json ['Mac Suffix'],
    operatingSystem : json ['Operating System'],
    cpu : json ['Cpu'],
    drive : json ['Drive'],
    ram : json ['Ram'],
    network : json ['Network'],
    internet : json ['Internet'],
  );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['uuid'] = uuid;
  //   data['deviceName'] = deviceName;
  //   data['deviceType'] = deviceType;
  //   data['responsible'] = responsible;
  //   data['job'] = job;
  //   data['manager'] = manager;
  //   data['phone'] = phone;
  //   data['privatePhone'] = privatePhone;
  //   data['room'] = room;
  //   data['domainName'] = domainName;
  //   data['ipAddress'] = ipAddress;
  //   data['macAddress'] = macAddress;
  //   data['operatingSystem'] = operatingSystem;
  //   data['cpu'] = cpu;
  //   data['drive'] = drive;
  //   data['ram'] = ram;
  //   data['network'] = network;
  //   data['internet'] = internet;
  //   return data;
  // }



}
