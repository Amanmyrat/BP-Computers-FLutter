import 'dart:core';
import 'package:bp_computers/models/computer.dart';
import 'package:hive/hive.dart';

part 'computerList.g.dart';

@HiveType(typeId: 1)
class ComputerList {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late List<Computer> computerList;

  ComputerList({required this.name, required this.computerList});

}
