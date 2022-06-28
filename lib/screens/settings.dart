import 'package:flutter/material.dart';
import 'package:test/screens/add_favorite.dart';
import 'package:test/screens/profile.dart';
import 'package:test/screens/nav.dart';
import 'package:test/utils/color_utils.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings'),
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
            icon: const Icon(Icons.person),
            label: const Text('Profile'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profilescreen()),
              );
            },
            style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 0),
                textStyle: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}
