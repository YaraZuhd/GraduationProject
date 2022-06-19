import 'package:flutter/material.dart';
import 'package:test/screens/add_kid.dart';
import 'package:test/screens/home_screen.dart';
import 'package:test/screens/select_coordinates.dart';
import 'package:test/screens/select_from_map.dart';
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
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
            icon: Icon(Icons.gps_fixed),
            label: 'Tracking Kid',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 149, 71, 163),
        onTap: _onItemTapped,
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Please Chose One Of \nThe Following To Determine \nRed & Green Areas\n Safe And Non-Safe Areas',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'PlayfairDisplay'),
                ),
                const SizedBox(
                  height: 80,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Colors.cyan,
                        Colors.indigo,
                        Colors.purpleAccent
                      ]),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5),
                      ]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: const Size(500, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0)),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectFromMap()))
                    },
                    child: const Text(
                      'Go To Map To Determine The Areas',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Colors.cyan,
                        Colors.indigo,
                        Colors.purpleAccent
                      ]),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5),
                      ]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: const Size(500, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0)),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectCoordinates()))
                    },
                    child: const Text(
                      'Go And specify the coordinates of the Location',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ))),
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AppSettings()));
      }
    });
  }
}
