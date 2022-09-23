import 'dart:ui';

import 'package:bp_computers/models/computer.dart';
import 'package:bp_computers/models/computerList.dart';
import 'package:bp_computers/services/api_servoce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    });
  }

  Widget listTemplate(index) {
    var deviceType = computers[index].deviceType;

    var qrCodeColor = const Color(0xff0064E0);
    switch (deviceType) {
      case "Şahsy kompýuter":
        qrCodeColor = const Color(0xff0064E0);
        break;
      case "Noutbuk":
        qrCodeColor = const Color(0xff535353);
        break;
      case "Monoblok":
        qrCodeColor = const Color(0xffda9c1b);
        break;
      case "Serwer enjamy":
        qrCodeColor = const Color(0xff006100);
        break;
      default:
        qrCodeColor = Colors.red;
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
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place,
                              size: 20,
                              color: Color(0xff04485F),
                              // color: qrCodeColor,
                            ),
                            SizedBox(
                              width: 190,
                              child: Text(
                                maxLines: 2,
                                computers[index].office,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    color: Color(0xff04485F)),
                                // textAlign: TextAlign.center,
                              ),
                            )
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
                            Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/scan');
                                        },
                                        child: const Icon(
                                      Icons.qr_code_2_outlined,
                                      color: Color(0xff04485F),
                                    )
                            )),
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
    List<Computer> comps = await getComputersData(context);
    if (comps.isNotEmpty) {
      box.put("offline_computers",
          ComputerList(name: "offline computers list", computerList: comps));
      setState(() {
        computers = comps;
        untouchableComputers = comps;
        isLoading = !isLoading;
      });
      showToast(context, "Üstünlikli täzelendi");
    } else{
      setState(() {
        isLoading = !isLoading;
      });
      showToast(context, "Täzeden synanyşyp görüň");
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
          computer.uuid.toString().toLowerCase().contains(input) ||
          computer.deviceName.toString().toLowerCase().contains(input) ||
          computer.deviceType.toString().toLowerCase().contains(input) ||
          computer.phone.toString().toLowerCase().contains(input) ||
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

Future<List<Computer>> getComputersData(context) async {
  List<Computer> computers;
  print(
      " ------------------------------ LOADING COMPUTERS------------------------------");
  try {
    computers = (await ApiService().fetchComputers());
    return computers;
  }catch (e) {
    return <Computer>[];
  }

}
void showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(text),
      action: SnackBarAction(label: 'Bolýar', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}