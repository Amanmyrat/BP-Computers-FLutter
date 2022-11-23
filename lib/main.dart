import 'package:bp_computers/pages/computersListScreen.dart';
import 'package:bp_computers/pages/computerDetailsScreen.dart';
import 'package:bp_computers/pages/scanScreen.dart';
import 'package:bp_computers/providers/ThemeProvider.dart';
import 'package:bp_computers/utils/SettingsConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/computer.dart';
import 'models/computerList.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ComputerAdapter());
  Hive.registerAdapter(ComputerListAdapter());
  print("---------------------HIVE---------------------------INITIALIZED-----------------------------");

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/computersList': (context) => const ComputersListScreen(),
        '/computerDetails': (context) => const ComputerDetailsScreen(),
        '/scan': (context) => const ScanScreen(),
      },
    ),)
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool positive = false;
  late final prefs;
  String theme = "";

  @override
  void initState() {
    super.initState();
    initVerification();
  }

  void initVerification() async {
    prefs = await SharedPreferences.getInstance();
    verifyTheme();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff04485F),
    ));
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: SettingsConfig().getColor(
                context
                    .watch<ThemeProvider>()
                    .currentTheme,
                "backgroundColor") ??
                Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 15),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: positive,
                          first: false,
                          second: true,
                          dif: 20.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 40,
                          indicatorColor: Colors.purpleAccent,
                          innerColor: positive ? const Color(0xff04485F) : Colors.amber,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (b) async {
                            changeTheme(context, b ? "light" : "dark", b);
                          },
                          colorBuilder: (b) => b ? Colors.white : Colors.white,
                          // colorBuilder: (b) => b
                          //     ? const Color(0xff04485F)
                          //     : const Color(0xffffdf00),
                          iconBuilder: (value) => value
                              ? const Icon(
                                  Icons.dark_mode,
                                  color: Colors.blueGrey,
                                )
                              : const Icon(
                                  Icons.light_mode,
                                  color: Colors.amber,
                                ),
                          // textBuilder: (value) => value
                          //     ? const Center(child: Text('Garaňky..'))
                          //     : const Center(child: Text('Ýagty :)')),
                        ),
                      )
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
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            color: SettingsConfig().getColor(
                                context
                                    .watch<ThemeProvider>()
                                    .currentTheme,
                                "textColor") ??
                                const Color(0xff04485F)),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 200,
                        height: 45,
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/computersList');
                          },
                          icon: Icon(
                            MdiIcons.formatListText,
                            size: 24.0,
                            color: SettingsConfig().getColor(
                              context
                                  .watch<ThemeProvider>()
                                  .currentTheme,
                              "buttonTextColor") ??
                              const Color(0xff04485F),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  SettingsConfig().getColor(
                                      context
                                          .watch<ThemeProvider>()
                                          .currentTheme,
                                      "buttonBackgroundColor") ??
                                      const Color(0xff04485F)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          label: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              //apply padding to some sides only
                              child: Text(
                                'Sanawlary görmek',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                    color: SettingsConfig().getColor(
                                    context
                                        .watch<ThemeProvider>()
                                        .currentTheme,
                                    "buttonTextColor") ??
                                    const Color(0xff04485F),
                                ),
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/scan');
                          },
                          icon: Icon(
                            MdiIcons.qrcodeScan,
                            size: 24.0,
                            color: SettingsConfig().getColor(
                                context
                                    .watch<ThemeProvider>()
                                    .currentTheme,
                                "buttonTextColor") ??
                                const Color(0xff04485F),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  SettingsConfig().getColor(
                                      context
                                          .watch<ThemeProvider>()
                                          .currentTheme,
                                      "buttonBackgroundColor") ??
                                      const Color(0xff04485F)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          label: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              //apply padding to some sides only
                              child: Text(
                                'Skan etmek',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                    color: SettingsConfig().getColor(
                                    context
                                        .watch<ThemeProvider>()
                                        .currentTheme,
                                    "buttonTextColor") ??
                                    const Color(0xff04485F)),
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
                            "Türkmenistanyň Baş Prokuraturasy \n".toUpperCase(),
                            // + " " + theme + " " + positive.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Montserrat",
                                color: SettingsConfig().getColor(
                                    context
                                        .watch<ThemeProvider>()
                                        .currentTheme,
                                    "textColor") ??
                                    const Color(0xff04485F)),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> changeTheme(BuildContext context, String newTheme, bool b) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', newTheme);
    context.read<ThemeProvider>().changeTheme(newTheme);

    setState(() => {
      theme = newTheme,
      positive = b,
    });
  }

  verifyTheme() {
    String? newTheme = prefs.getString('themeMode');
    if (newTheme == null) {
      context.read<ThemeProvider>().changeTheme("light");
      setState(() => {
        theme = "light",
        positive = false,
      });
    } else {
      context.read<ThemeProvider>().changeTheme(newTheme);
      setState(() => {
        theme = newTheme,
        positive = newTheme == "light" ? false : true,
      });
    }
  }
}
