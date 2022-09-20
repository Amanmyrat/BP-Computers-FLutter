import 'package:bp_computers/pages/computersListScreen.dart';
import 'package:bp_computers/pages/computerDetailsScreen.dart';
import 'package:bp_computers/pages/scanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'models/computer.dart';
import 'models/computerList.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ComputerAdapter());
  Hive.registerAdapter(ComputerListAdapter());
  print("---------------------HIVE---------------------------INITIALIZED-----------------------------");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/computersList': (context) => const ComputersListScreen(),
      '/computerDetails': (context) => const ComputerDetailsScreen(),
      '/scan': (context) => const ScanScreen(),
    },
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff04485F),
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: const Offset(160, -30),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Color(0xffeeeeee),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Transform.translate(
                    offset: const Offset(0, -40),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset("assets/images/search.svg",
                          semanticsLabel: 'Search Illustration',
                          width: 250,
                          fit: BoxFit.scaleDown),
                    )),
                Text(
                  "Türkmenistanyň Prokuratura edaralarynyň kompýuterlarynyň sanawy"
                      .toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      color: Color(0xff04485F)),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 200,
                  height: 45,
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {Navigator.pushNamed(context, '/computersList');},
                    icon: const Icon(
                      MdiIcons.formatListText,
                      size: 24.0,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff04485F)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4),
                        //apply padding to some sides only
                        child: Text(
                          'Sanawlary görmek',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 45,
                  margin: const EdgeInsets.only(top: 15),
                  child: ElevatedButton.icon(
                    onPressed: () {Navigator.pushNamed(context, '/scan');},
                    icon: const Icon(
                      MdiIcons.qrcodeScan,
                      size: 24.0,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff04485F)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4),
                        //apply padding to some sides only
                        child: Text(
                          'Skan etmek',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    "Türkmenistanyň Baş Prokuraturasy".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                        color: Color(0xff04485F)),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}