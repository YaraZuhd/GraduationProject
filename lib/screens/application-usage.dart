import 'package:flutter/material.dart';
import 'package:test/screens/add_favorite.dart';
import 'package:test/screens/add_kid.dart';
import 'package:test/utils/color_utils.dart';
import 'package:test/screens/nav.dart';

class Usage extends StatefulWidget {
  const Usage({Key? key}) : super(key: key);

  @override
  State<Usage> createState() => _SettingsState();
}

class _SettingsState extends State<Usage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Applications Usage'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: '',
                          )));
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
                ])),
          )),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: Column(children: [
          TextButton.icon(
            icon: Image.asset(
              //        <-- Image
              'assets/images/youicon.PNG',
              height: 35,
              fit: BoxFit.cover,
              // color: Color.fromARGB(255, 166, 100, 178),
            ),
            label: const Text(
              'Youtube                      1 h 12 mins',
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: '',
                        )),
              );
            },
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 0, 0, 0),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton.icon(
            icon: Image.asset(
              //        <-- Image
              'assets/images/logo2.png',
              height: 35,
              fit: BoxFit.cover,
              color: Color.fromARGB(255, 166, 100, 178),
            ),
            label: const Text('PMK                                    50 mins'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: '',
                        )),
              );
            },
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 0, 0, 0),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton.icon(
            icon: Image.asset(
              //        <-- Image
              'assets/images/insicon.PNG',
              height: 35,
              fit: BoxFit.cover,
              //color: Color.fromARGB(255, 166, 100, 178),
            ),
            label: const Text('Instagram                        42 mins'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: '',
                        )),
              );
            },
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 0, 0, 0),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton.icon(
            icon: Image.asset(
              //        <-- Image
              'assets/images/facicon.PNG',
              height: 35,
              fit: BoxFit.cover,
              //color: Color.fromARGB(255, 166, 100, 178),
            ),
            label: const Text('Facebook                         15 mins'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: '',
                        )),
              );
            },
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 0, 0, 0),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ]),
      ),
    );
  }
}
