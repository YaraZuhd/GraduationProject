import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/screens/home_screen.dart';
import 'package:test/screens/popup.dart';
import 'package:test/utils/color_utils.dart';

class SelectFromMap extends StatefulWidget {
  const SelectFromMap({Key? key}) : super(key: key);

  @override
  State<SelectFromMap> createState() => _SelectFromMapState();
}

class _SelectFromMapState extends State<SelectFromMap> {
  final Completer<GoogleMapController> _controller = Completer();
  //String _address = ""; // create this variable
  static const CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(31.768319, 35.21371),
    //LatLng(32.0884848, 35.1768524),
    zoom: 14.987,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Text('Select From Map'),
          ),
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
      body: GoogleMap(
        //mapType: MapType.hybrid,
        initialCameraPosition: _initalCameraPosition,
        // CameraPosition(
        //     target: LatLng(double.parse(lat), double.parse(long)), zoom: 14.87),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (latLng) {
          //print('${latLng.latitude}, ${latLng.longitude}');
          double lat = latLng.latitude;
          double long = latLng.longitude;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PopUpScreen(lat, long),
            ),
          );
        },
      ),
    );
  }
}
