import 'package:bp_computers/main.dart';
import 'package:bp_computers/models/computerList.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:indexed/indexed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../models/computer.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  List<Computer> computers = [];

  var tryAgain = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initHive();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff3f3f3),
      body: Scaffold(
          body: Indexer(
            children: [
              Indexed(
                index: 2,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          'assets/animation/qr-scanning.json',
                          frameRate: FrameRate.max,
                          // width: 50,
                          height: 250,
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              tryAgain
                  ? Indexed(
                index: 2,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: 230,
                        margin: const EdgeInsets.only(top: 350),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            print("----------------------------------RESTART---------------------");
                            Navigator.pushNamed(context, '/scan');
                          },
                          icon: const Icon(
                            Icons.refresh_outlined,
                            size: 24.0,
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  const Color(0xff04485F)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                          label: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              //apply padding to some sides only
                              child: Text(
                                'Täzeden skan etmek',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : Container(),
              Indexed(
                index: 1,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> initHive() async {
    Box box = await Hive.openBox("offline_computers");
    ComputerList comps = await box.get("offline_computers");
    setState(() {
      computers = comps.computerList;
    });
  }

  void retryScanner(){
    // setState(() {
    //   tryAgain = false;
    // });
    // controller?.resumeCamera();
    print("----------------------------------RESTART---------------------");
    Navigator.pushNamed(context, '/scan');
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      final foundComp = computers.where((computer) {
      final code =
            result!.code?.replaceAll(RegExp(r'[^0-9]'), '').toLowerCase();
        print("${computer.uuid.toString().toLowerCase()} ---- ${code!}");
        return computer.uuid.toString().toLowerCase() == code;
      });

      print("found item ---$foundComp -- ${foundComp.first.responsible}");

      if (foundComp.isNotEmpty) {
        setState(() {
          tryAgain = true;
        });
        Navigator.pushNamed(context, '/computerDetails',
            arguments: {'computer': foundComp.first});
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
