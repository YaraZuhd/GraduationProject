import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/screens/add_favorite.dart';
import 'package:test/screens/add_kid.dart';
import 'package:test/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:test/screens/signin_screen.dart';
import 'dart:async';
import 'package:test/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  int _selectedIndex = 1;

  static const CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(31.768319, 35.21371),
    zoom: 14.987,
  );

  static const CameraPosition _secondCameraPosition = CameraPosition(
    target: LatLng(40.741895, -73.989308),
    zoom: 14.987,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // Don't show the leading button
          title: const Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 20, 0),
            child: Text('Protect My Kids'),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                // onTap: () {},
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    });
                  },
                ),
              ),
            ),
          ],
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
        // type: BottomNavigationBarType.shifting,
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
      body: GoogleMap(
        //mapType: MapType.hybrid,
        initialCameraPosition: _secondCameraPosition,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 166, 100, 178),
        foregroundColor: Colors.white,
        onPressed: _goToHome,
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  Future<void> _goToHome() async {
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_initalCameraPosition));
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
