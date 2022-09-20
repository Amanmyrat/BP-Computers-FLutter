import 'dart:ui';

import 'package:bp_computers/models/computer.dart';
import 'package:bp_computers/models/computerDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ComputerDetailsScreen extends StatefulWidget {
  const ComputerDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ComputerDetailsScreen> createState() => _ComputerDetailsScreenState();
}

class _ComputerDetailsScreenState extends State<ComputerDetailsScreen> {
  List<ComputerDetail> computers = [];

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Computer comp = arguments['computer'];
    initComputer(comp);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff04485F),
    ));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff3f3f3),
        body: Stack(children: [
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
            body: Column(children: [
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(237, 217, 157, 0.3),
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "TÜRKMENISTANYŇ PROKURATURASY",
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              color: Color(0xff1F2045)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Image.asset(
                                          "assets/images/logo.png",
                                          // fit: BoxFit.fill,
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 20,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color(0xff1F2045),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "TP-${comp.uuid}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Montserrat",
                                                  color: Color(0xff1F2045)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Lottie.asset(
                                          'assets/animation/qr-code.json',
                                          frameRate: FrameRate.max,
                                          // width: 50,
                                          height: 250,
                                          // fit: BoxFit.fill,
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          )),
                      const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "Seljeriş we maglumatlar bölümi - Seljeriş we maglumatlar bölümi   Seljeriş we maglumatlar bölümi",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Montserrat",
                                  color: Color(0xff1F2045)),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 8,
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20,20,20,20),
                    itemCount: computers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 26,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1 / 1.15,
                    ),
                    itemBuilder: (context, index) => DetailItem(computers[index]),
                  )),
            ]),
          ),
        ]));
  }

  void initComputer(Computer comp) {
    computers.clear();
    var deviceTypes = ['Şahsy kompýuter',"Monoblok","Noutbuk","Serwer enjamy"];

    computers.add(ComputerDetail(
        name: 'Enjamyň ady',
        title: comp.deviceName,
        color: const Color(0xff182747),
        icon: const Icon(Icons.desktop_mac)));
    computers.add(ComputerDetail(
        name: 'Enjamyň görnüşi',
        title: deviceTypes[int.parse(comp.deviceType)-1],
        color: const Color(0xff647E68),
        icon: const Icon(Icons.devices_other)));
    computers.add(ComputerDetail(
        name: 'Jogapkär işgär',
        title: comp.responsible,
        color: const Color(0xff17C74A),
        icon: const Icon(Icons.person)));
    computers.add(ComputerDetail(
        name: 'Prokuratura',
        title: comp.office,
        color: const Color(0xff4B75FF),
        icon: const Icon(MdiIcons.officeBuildingMarker)));
    computers.add(ComputerDetail(
        name: 'Wezipesi',
        title: comp.job,
        color: const Color(0xffC21578),
        icon: const Icon(MdiIcons.briefcaseVariantOutline)));
    computers.add(ComputerDetail(
        name: 'Otag Belgisi',
        title: comp.room,
        color: const Color(0xffB8995A),
        icon: const Icon(MdiIcons.numeric8BoxOutline)));
    computers.add(ComputerDetail(
        name: 'Telefon Belgisi',
        title: comp.phone,
        color: const Color(0xff400D51),
        icon: const Icon(MdiIcons.phoneClassic)));
    computers.add(ComputerDetail(
        name: 'IP Address',
        title: comp.ipAddress,
        color: const Color(0xffFF8C42),
        icon: const Icon(MdiIcons.ip)));
    computers.add(ComputerDetail(
        name: 'MAC Address',
        title: comp.macAddress,
        color: const Color(0xffD01B3B),
        icon: const Icon(MdiIcons.numeric)));
    computers.add(ComputerDetail(
        name: 'CPU',
        title: comp.cpu,
        color: const Color(0xff4F0572),
        icon: const Icon(MdiIcons.cpu64Bit)));
    computers.add(ComputerDetail(
        name: 'RAM',
        title: "${comp.ram} GB",
        color: const Color(0xffB05043),
        icon: const Icon(MdiIcons.movieSettings)));
    computers.add(ComputerDetail(
        name: 'Operasion sistema',
        title: comp.operatingSystem,
        color: const Color(0xff506D84),
        icon: const Icon(MdiIcons.microsoftWindows)));
    computers.add(ComputerDetail(
        name: 'Ýady',
        title: comp.drive,
        color: const Color(0xff61481C),
        icon: const Icon(MdiIcons.harddisk)));
    computers.add(ComputerDetail(
        name: '',
        title: comp.network == "1" ? "Tora birikdirilen" : "Tora Birikdirilmedik",
        color: const Color(0xffE3C770),
        icon: comp.network == "1" ? const Icon(MdiIcons.lanConnect) : const Icon(MdiIcons.lanDisconnect),
    ));

    setState(() {
      computers = computers;
    });
  }
}

class DetailItem extends StatelessWidget {
  final ComputerDetail computer;

  const DetailItem(this.computer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromRGBO(237, 217, 157, 0.3),
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromRGBO(237, 217, 157, 0.1),
                  width: 1,
                ),
                gradient: LinearGradient(
                    colors: [
                      const Color(0xffffffff),
                      computer.color,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 0.4],
                    tileMode: TileMode.clamp),
              ),
              child: IconButton(
                onPressed: () {},
                icon: computer.icon,
                color: Colors.white,
                iconSize: 36.0,
              )),
          const SizedBox(height: 15),
          Text(
            computer.name,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
                color: Color(0xff1F2045)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            computer.title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: "Montserrat",
                color: Color(0xffDAA520)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
