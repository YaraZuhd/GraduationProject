import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/screens/add_kid.dart';
import 'package:test/screens/settings.dart';
import 'package:test/screens/signin_screen.dart';
import 'dart:async';
import 'package:test/utils/color_utils.dart';
import 'package:test/screens/location.dart';
import 'package:test/screens/application-usage.dart';
import 'package:test/screens/notification_parent.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 10;

  static const CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(31.9934, 35.1989),
    zoom: 14.987,
  );

  static const CameraPosition _secondCameraPosition = CameraPosition(
    target: LatLng(31.768319, 35.21371),
    zoom: 14.987,
  );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DrawerHeader(),
                const SizedBox(
                  height: 16.0,
                ),
                DrawerNavigationItem(
                  iconData: Icons.home_filled,
                  title: "Home",
                  selected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                                  title: '',
                                )));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.gps_fixed,
                  title: "Track your Kids",
                  selected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.location_city,
                  title: "Determine Red & Green Areas",
                  selected: selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.mobile_friendly,
                  title: "Applications Usage",
                  selected: selectedIndex == 3,
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Usage()));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.history,
                  title: "History",
                  selected: selectedIndex == 4,
                  onTap: () {
                    setState(() {
                      selectedIndex = 4;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.add,
                  title: "Add kid",
                  selected: selectedIndex == 5,
                  onTap: () {
                    setState(() {
                      selectedIndex = 5;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddKid()));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.notifications,
                  title: "Notification & Message",
                  selected: selectedIndex == 6,
                  onTap: () {
                    setState(() {
                      selectedIndex = 6;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationP()));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.settings,
                  title: "Settings",
                  selected: selectedIndex == 7,
                  onTap: () {
                    setState(() {
                      selectedIndex = 7;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
                DrawerNavigationItem(
                  iconData: Icons.logout,
                  title: "Logout",
                  selected: selectedIndex == 8,
                  onTap: () {
                    setState(() {
                      selectedIndex = 8;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 20, 0),
            child: Text('Protect My Kids'),
          ),
          actions: <Widget>[],
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
}

class DrawerNavigationItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool selected;
  final Function() onTap;
  const DrawerNavigationItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      leading: Icon(iconData),
      onTap: onTap,
      title: Text(title),
      selectedTileColor: Color.fromARGB(255, 166, 100, 178),
      selected: selected,
      selectedColor: Colors.black87,
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 166, 100, 178),
          radius: 35,
          backgroundImage: AssetImage(
            "assets/images/logo1.png",
          ),
        ),
        Text(
          "  Protect My Kids",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
