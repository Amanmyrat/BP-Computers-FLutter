import 'dart:ui';

import 'package:bp_computers/models/computer.dart';
import 'package:bp_computers/models/computerList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const _credentials = r''' 
  {
    "type": "service_account",
    "project_id": "bp-computers-361913",
    "private_key_id": "470d71f554816fa30259f6d58c8a55f7e24ee47d",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDSk5uPlANyVdmM\ndxTz+nGAFSFCJFUWJZjm2J0RJbR3mf82M9c3xD9HhZSl5smSW5prALYqCS/jJkVF\ny7YVtt6txRXd3/6+tgaWWrqpptGMNq4kEBmDphm8Kibiwv/S+6dN3uvaak/yf+dD\nHJWzgjYvffkJE7rnyq5I9QOETwn3gsXHd5f2tkvwfzAvX+wCLra/TNeVeD4FnhuE\nsVStLAdUZQRiB5iSgqQUFNppu2vZslEpSYPvZycAPlA+dtW9aXT2av6AHGa63JWg\ngRugbU9xGMaNxHuTBwPvKSpFVILsDuLPqSI+awquqe4MDEVslf3w0NrCObRARMOC\nEvyrt2WlAgMBAAECggEAFlrFMOuC/NL6/VvG8FUDUkLr/PGOdtjBmqrJlysW4CY2\nXwgHLkxkdgX1pIcTmbilHqbnWnRkjmC0X0HOWrpxzqYVjtsGAt5KuhDNBXry0/Jv\nb4n7VhZ+tOhkqGi7Gn13YrTqT42UXydk4vhYjBikAqFaRrRpgHdBI/hJdJ+kweRW\noug9AuZM7H539w2PyGm34dXwoBydGEPE6T+NV/UJA+MNJ6yC5NGBBBzJ8rVttNT8\nE3GY1PRv56wx5nENA/niN+zUNvr/NSETq4T/VwHGOK2m3W1jkzmprb8LKkk3nddf\nZtUgjJtk6HsHE2RvMU6UClEY4RkiJUoFz6dlnZIQIQKBgQD9mvNyXWcz1VGO58Ee\nLQy6M7oXW4K2E89Sqziy3Mmhl5j/WUUSsSsd4BC0niu9cmV3eMQnXcf/HS9ffFBm\nVTLXKl4nnlRbnbN2f/DAh5V1Dqzf0MAB30Esm0kqbKv2XC0yOcTFHeQ7icszzNy1\n+plgpfONyH/4a32auGuwHAARHwKBgQDUkKRVdwpqU92xXWVyEKMzwVN4RtEIy5tG\nwGJP5njt/q7v75RPqwRMZiOeNY5K0yKf4UZoARctIebZTvHQEYOcQjlVH25UHKjY\nzQmgncHgrBEOqKXZWTW3Q3ZJ4SHB+ZiXoWbjfX/JaJOVHeQ0quGhYXCP6XYbQ4CX\n/wlTP0ScuwKBgQDChv7B9L9a1P/wW/iYCvo+Qbs2e20x+NQIl2mwWQcYuk4TYAhJ\npDhsfBiUUtc+Q+ds0uezQo5MM7jIx3RsamHLBaafQSV3+OlVtiGXrOiJl64nJ9qA\nFR3K93oR3rWxDVdltUYn5RvSR4nku/l4ZTcNGX5OfUMb7Ge2LEv+FBxBBQKBgQCN\nkB7BhFv9YAke3DJ5ercV+sSaL597Gg45WlqfF8Clz5210XqWbDCaqNNDxCsVjfNb\nQu5eyYsj1ZYmVzsX9PIPmNMR67LQdZ3FdRfaTfYWqMFbX9nEHHN3r4gRv8t5ob6M\nDUO2cZgvDGRtRND8eml1zqzmSvcLRTNZBtKxDEunjQKBgEsvE5bEgy9hzmOtn/SM\n3v1vhSQ3GoWvtAwhdnCA+pZlX4qYtHUUOO1mAedW9z34M37k9h9x7hxcolKa6/RY\nz1+wdSbu0jBXaXCkPK48LvWBOstVNkiQJxiHdHuBfKSUofkAd9viseXp1cUpCBK2\nvjKSlkqotth5egXmgto7GAG0\n-----END PRIVATE KEY-----\n",
    "client_email": "bp-computers@bp-computers-361913.iam.gserviceaccount.com",
    "client_id": "105000480841019104100",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bp-computers%40bp-computers-361913.iam.gserviceaccount.com"
  }
  ''';
const _spreadsheetId = '1VROpjZ27C3veVhqbF3LxwBVp78B4k64S8aPXKd5tsmw';

late Box box;

class ComputersListScreen extends StatefulWidget {
  const ComputersListScreen({Key? key}) : super(key: key);

  @override
  State<ComputersListScreen> createState() => _ComputersListScreenState();
}

class _ComputersListScreenState extends State<ComputersListScreen> {
  List<Computer> untouchableComputers = [];
  List<Computer> computers = [];
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initHive();

      // var comps = await getComputersData();
      // setState(() {
      //   computers = comps;
      // });
    });
  }

  Widget listTemplate(index) {
    var deviceType = computers[index].deviceType;
    if (deviceType is int) {
      print("Integer");
    }
    var qrCodeColor = const Color(0xff0064E0);
    switch (deviceType) {
      case "1":
        qrCodeColor = const Color(0xff0064E0);
        break;
      case "2":
        qrCodeColor = const Color(0xff535353);
        break;
      case "3":
        qrCodeColor = const Color(0xffda9c1b);
        break;
      case "4":
        qrCodeColor = const Color(0xff006100);
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/computerDetails',
            arguments: {'computer': computers[index]});
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromRGBO(237, 217, 157, 0.3),
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        height: 100,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.qr_code_2,
                      size: 70,
                      color: qrCodeColor,
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "TP-${computers[index].uuid}",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                color: Color(0xff04485F)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place,
                              size: 20,
                              color: Color(0xff04485F),
                              // color: qrCodeColor,
                            ),
                            Text(
                              computers[index].office,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat",
                                  color: Color(0xff04485F)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, top: 2),
                          child: Text(
                            computers[index].responsible,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                color: Color(0xff809198)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff04485F),
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff3f3f3),
      body: Stack(
        children: [
          Transform.rotate(
            angle: -0.80,
            child: Transform.translate(
                offset: const Offset(200, -100),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/images/borderedRectangle.svg',
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                  ),
                )),
          ),
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 60, 16, 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromRGBO(237, 217, 157, 0.3),
                              width: 1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),

                        // height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: TextField(
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Gözleg',
                                ),
                                onChanged: searchComputer,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/scan');
                                },
                                child: const Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.qr_code_2_outlined,
                                      color: Color(0xff04485F),
                                    ))),
                            isLoading
                                ? const SizedBox(width: 10)
                                : const SizedBox(width: 0),
                            Expanded(
                              flex: 1,
                              child: isLoading
                                  ? const Center(
                                      heightFactor: 1,
                                      widthFactor: 1,
                                      child: SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.download_outlined,
                                      ),
                                      onPressed: () => getNewData(),
                                    ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 10,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                          itemCount: computers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == computers.length) {
                              return const SizedBox(height: 15);
                            } else {
                              return listTemplate(index);
                            }
                          }),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void getNewData() async {
    setState(() {
      isLoading = !isLoading;
    });
    List<Computer> comps = await getComputersData();
    if (comps.isNotEmpty) {
      // Hive.box('offline_computers').clear();
      box.put("offline_computers",
          ComputerList(name: "offline computers list", computerList: comps));
      setState(() {
        computers = comps;
        untouchableComputers = comps;
        isLoading = !isLoading;
      });
    }
  }

  Future<void> initHive() async {
    box = await Hive.openBox("offline_computers");
    print(
        "---------------------HIVE---------------------------OPEN-----------------------------");
    ComputerList comps = await box.get("offline_computers");
    print(
        "---------------------HIVE---------------------------GET-----------------------------");
    setState(() {
      computers = comps.computerList;
      untouchableComputers = comps.computerList;
    });
    print(comps.computerList);
  }

  void searchComputer(String query) {
    if (query.isEmpty) {
      setState(() {
        computers = untouchableComputers;
      });
      return;
    }
    final filteredComps = untouchableComputers.where((computer) {
      final input = query.toLowerCase();
      return computer.responsible.toLowerCase().contains(input) ||
          computer.uuid.toLowerCase().contains(input) ||
          computer.office.toLowerCase().contains(input) ||
          computer.job.toLowerCase().contains(input) ||
          computer.domainName.toLowerCase().contains(input) ||
          computer.ipAddress.toLowerCase().contains(input) ||
          computer.macAddress.toLowerCase().contains(input);
    }).toList();

    setState(() {
      computers = filteredComps;
    });
  }
}

// void getComputersData() async {
Future<List<Computer>> getComputersData() async {
  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle("Computers");

  if (sheet == null) return <Computer>[];

  print(
      " ------------------------------ LOADING ------------------------------");
  final computers = await sheet.values.map.allRows();
  print(
      " ------------------------------ LOADED ------------------------------");
  // print(computers);
  return computers == null
      ? <Computer>[]
      : computers.map(Computer.fromJson).toList();

  // List<Computer> list = [];
  // computers!.forEach((computer) => list.add(
  //     Computer(
  //         office: computer["Prokuratura"] ?? "-",
  //         uuid: computer["Uuid"] ?? "-",
  //         deviceName: computer["Device Name"] ?? "-",
  //         deviceType: computer["Device Type"] ?? "-",
  //         responsible: computer["Responsible Person"] ?? "-",
  //         job: computer["Job Title"] ?? "-",
  //         manager: computer["Department Manager"] ?? "-",
  //         phone: computer["Phone"] != null ? ("993 ${computer["Phone Prefix"] ?? "-"} ${computer["Phone"] ?? "-"}") : "-",
  //         privatePhone: computer["Private Phone"] != null ? ("993 ${computer["Private Phone"] ?? "-"}") : "-",
  //         room: computer["Room"] ?? "-",
  //         domainName: computer["Domain Name"] ?? "-",
  //         ipAddress: computer["Ip Suffix"] != null ? ("${computer["Ip Prefix"] ?? "-"}: ${computer["Ip Suffix"] ?? "-"}") : "-",
  //         macAddress: computer["Mac Suffix"] != null ? ("${computer["Mac Prefix"] ?? "-"}: ${computer["Mac Suffix"] ?? "-"}") : "-",
  //         operatingSystem: computer["Operating System"] ?? "-",
  //         cpu: computer["Cpu"] ?? "-",
  //         drive: computer["Drive"] ?? "-",
  //         ram: computer["Ram"] ?? "-",
  //         network: computer["Network"] ?? "-",
  //         internet: computer["Internet"] ?? "-",
  //     )
  // ));

  // print("Inserted");
  // await sheet!.values.insertValue("Aman", column: 1, row: 1);
}
