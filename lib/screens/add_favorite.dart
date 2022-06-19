import 'package:flutter/material.dart';
import 'package:test/screens/add_kid.dart';
import 'package:test/screens/nav.dart';
import 'package:test/screens/settings.dart';
import 'package:test/utils/color_utils.dart';

class AddFavorite extends StatefulWidget {
  const AddFavorite({Key? key}) : super(key: key);

  @override
  State<AddFavorite> createState() => _AddFavoriteState();
}

class _AddFavoriteState extends State<AddFavorite> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add Favorite Places'),
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
      bottomNavigationBar: BottomNavigationBar(
        mouseCursor: SystemMouseCursors.grab,
        iconSize: 20,
        selectedFontSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Kid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 149, 71, 163),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddKid()));
      } else if (index == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddFavorite()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Settings()));
      }
    });
  }
}
